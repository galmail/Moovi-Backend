class Api::V1::GroupsController < Api::BaseController
    
    def index
      @groups = Group.joins(:users).where(["users.id = ?",current_user.id])
    end
    
    def create
      params.require(:video_id)
      params.require(:people)
      video = Video.find(params[:video_id])
      group = nil
      if video.group.nil?
        # create group
        group = Group.new()
        group.name = "Group #{video.id}"
        group.save
        video.group_id = group.id
        video.save
      else
        group = video.group
      end
      
      # add users to the group
      group.users = []
      participants = params[:people]
      participants.each { |person|
        user = User.find_by_email(person[:email])
        if user.nil?
          user = User.new({
            email: person[:email],
            first_name: person[:first_name],
            last_name: person[:last_name]
          })
          user.guest = true
          user.save(:validate => false)
        else
          if user.guest
            user.first_name = person[:first_name]
            user.last_name = person[:last_name]
            user.save(:validate => false)
          end
        end
        group.users << user
      }
      group.save
      
      # send invitations
      if params[:invite_group]
        if video.receiver.nil?
          render :json=> { error: "The video receiver is missing" }, status: :unprocessable_entity
          return false
        else
          group.users.each { |user|
            UserNotifier.send_join_my_video_email(video.moderator,user,video.id).deliver
          }
        end
      end
      render :json=> group.as_json, status: :created
    end
    
    # def update
      # params.require(:id)
      # clip_params = params.permit(:url)
      # clip = Clip.find(params[:id])
      # clip.update_attributes(clip_params)
      # render :json => clip.as_json, status: :ok
    # end

end