class Api::V1::VideosController < Api::BaseController
    
    def index
      videos_i_made = Video.where(["moderator_id = ?",current_user.id])
      videos_i_received = Video.where(["receiver_id = ? AND status = ?",current_user.id,Video.statuses[:ready]])
      #videos_i_participated = Video.joins(:groups,:users).where(["group_id = ?",current_user.id])
      @videos = videos_i_made.concat(videos_i_received)
    end
    
    def create
      # params.require(:title)
      video_params = params.permit(:title,:receiver_id)
      video = Video.new(video_params)
      video.moderator = current_user
      if video.save
        render :json=> video.as_json, status: :created
      else
        render :json=> video.errors, status: :unprocessable_entity
      end
    end
    
    def update
      params.require(:id)
      video_params = params.permit(:title,:cover,:receiver_id,:event_id,:event_celebration_date)
      video = Video.find(params[:id])
      video.update_attributes(video_params)
      
      if video.title.nil? and !video.receiver.nil? and !video.event.nil?
        video.title = "#{video.event.name} Video for #{video.receiver.first_name}"
        video.save
      end
      
      if (video.cover.nil? or !video.cover.include?('http')) and (!video.event.nil? and !video.event.pic_url.nil?)
        video.cover = video.event.pic_url
        video.save
      end
      
      if video.status == 'inactive'
        if !video.receiver.nil? and !video.event.nil?
          video.update_attributes({ status: Video.statuses[:pending]})
        end
      end
      
      render :json => video.as_json, status: :ok
    end
    
    def render
      params.require(:video_id)
      video = Video.find(params[:video_id])
      
      if video.moderator.id != current_user.id
        render :json => { error: "Only the moderator can render this video." }, status: :forbidden
        return false
      end

begin
      # call blender to render the video
      require 'net/http'
      uri = URI("#{ENV['BLENDER_URL']}/render")
      uri_params = { :output => "https://#{ENV['AWS_BUCKET']}.s3.amazonaws.com/videos/#{video.id}/", :videos => [] }
      video.clips.each{ |clip| uri_params[:videos] << clip.url }
      uri.query = URI.encode_www_form(uri_params)
      res = Net::HTTP.get_response(uri)
      if !res.is_a?(Net::HTTPSuccess)
        render :json => { error: "It looks like Blender Server is down." }, status: :internal_server_error
      else
        video.status = Video.statuses[:rendering]
        if video.save
          UserNotifier.send_video_is_rendering_email(video.moderator,video).deliver
          render :json => video.as_json, status: :ok
        else
          render :json => video.as_json, status: :internal_server_error
        end
      end
rescue
  render :json => { error: "It looks like Blender Server is down." }, status: :internal_server_error
end
      
      
      
      
      
    end

end