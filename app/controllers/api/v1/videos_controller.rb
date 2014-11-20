class Api::V1::VideosController < Api::BaseController
    
    def index
      @videos = Video.where(:user_id => current_user.id)
    end
    
    def create
      video_params = params.permit(:title)
      
      
      
      
    end
    
end