class Api::V1::BlenderController < ApplicationController
    
    def create
      params.require(:id)
      params.require(:url)
      
      video = Video.find(params[:id])
      video.url = params[:url]
      video.status = Video.statuses[:ready]
            
      if video.save
        UserNotifier.send_video_is_ready_email(video.moderator,video).deliver
        render :json=> video.as_json, status: :ok
      else
        render :json=> video.errors, status: :unprocessable_entity
      end
    end
    
end