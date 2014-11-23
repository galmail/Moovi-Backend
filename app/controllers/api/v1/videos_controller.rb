class Api::V1::VideosController < Api::BaseController
    
    def index
      #@videos = []
      videos_i_made = Video.where(["moderator_id = ?",current_user.id])
      videos_i_received = Video.where(["receiver_id = ? AND ready = ?",current_user.id,true])
      #videos_i_participated = Video.joins(:groups,:users).where(["group_id = ?",current_user.id])
      @videos = videos_i_made.concat(videos_i_received)
    end
    
    def create
      video_params = params.permit(:title)
      
      
      
      
    end
    
end