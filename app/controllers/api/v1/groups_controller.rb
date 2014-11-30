class Api::V1::GroupsController < Api::BaseController
    
    def index
      @groups = Group.joins(:users).where(["users.id = ?",current_user.id])
    end
    
    def create
      params.require(:video_id)
      video = Video.find(:video_id)
      if !video.group.nil?
        render :json=> video.group.as_json, status: :ok
      else
        group = Group.new()
        group.name = "Group - #{video.title}"
        if group.save
          video.group_id = group.id
          video.save
          render :json=> group.as_json, status: :created
        else
          render :json=> group.errors, status: :unprocessable_entity
        end
      end
    end
    
    # def update
      # params.require(:id)
      # clip_params = params.permit(:url)
      # clip = Clip.find(params[:id])
      # clip.update_attributes(clip_params)
      # render :json => clip.as_json, status: :ok
    # end

end