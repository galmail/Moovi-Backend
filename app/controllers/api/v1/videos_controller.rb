class Api::V1::VideosController < Api::BaseController
    
    def index
      videos_i_made = Video.where(["moderator_id = ?",current_user.id])
      videos_i_received = Video.where(["receiver_id = ? AND ready = ?",current_user.id,true])
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

end