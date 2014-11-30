class Api::V1::GroupsController < Api::BaseController
    
    def index
      @groups = Group.joins(:users).where(["users.id = ?",current_user.id])
    end
    
    def create
      params.require(:video_id)
      params.require(:people)
      video = Video.find(params[:video_id])
      if video.group.nil?
        # create group
        group = Group.new()
        group.name = "Group - #{video.title}"
        group.save
        video.group_id = group.id
        video.save
      end
      
      # add users to the group
      group.users = []
      participants = params[:people]
      participants.each { |person|
        user = User.find_by_email(person[:email])
        if user.nil?
          user = User.new(person)
          user.password = "123456789"
          user.guest = true
          user.save
        else
          if user.guest
            user.first_name = person[:first_name]
            user.last_name = person[:last_name]
            user.save
          end
        end
        group.users << user
      }
      group.save
      render :json=> group.as_json, status: :created
      #render :json=> group.errors, status: :unprocessable_entity
    end
    
    # def update
      # params.require(:id)
      # clip_params = params.permit(:url)
      # clip = Clip.find(params[:id])
      # clip.update_attributes(clip_params)
      # render :json => clip.as_json, status: :ok
    # end

end