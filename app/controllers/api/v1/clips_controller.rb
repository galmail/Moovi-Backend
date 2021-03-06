class Api::V1::ClipsController < Api::BaseController
    
    def index
      clips_i_made = Clip.where(["user_id = ?",current_user.id])
      @clips = clips_i_made
    end
    
    def create
      params.require(:url)
      params.require(:video_id)
      clip_params = params.permit(:url, :message, :video_id)
      clip = Clip.new(clip_params)
      clip.user = current_user
      if clip.save
        render :json=> clip.as_json, status: :created
      else
        render :json=> clip.errors, status: :unprocessable_entity
      end
    end
    
    def update
      params.require(:id)
      clip_params = params.permit(:url)
      clip = Clip.find(params[:id])
      clip.update_attributes(clip_params)
      render :json => clip.as_json, status: :ok
    end
    
end