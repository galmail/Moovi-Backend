class Api::V1::GroupsController < Api::BaseController
    
    def index
      @groups = Group.joins(:users).where(["user_id = ?",current_user.id])
    end
    

end