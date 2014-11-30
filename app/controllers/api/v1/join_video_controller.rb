class Api::V1::JoinVideoController < ApplicationController
    
    def create
      params.require(:url)
      params.require(:video_id)
      params.require(:user_id)
      clip = nil
      if params[:id]
        # update clip
        clip = Clip.find(params[:id])
        clip.url = params[:url]
        clip.video_id = params[:video_id]
        clip.user_id = params[:user_id]
      else
        clip_params = params.permit(:url, :message, :video_id, :user_id)
        clip = Clip.new(clip_params)
      end
      
      if clip.save
        render :json=> clip.as_json, status: :created
      else
        render :json=> clip.errors, status: :unprocessable_entity
      end
    end
    
end