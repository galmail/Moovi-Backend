class Api::V1::GroupsController < Api::BaseController
    
    def index
      @groups = Group.joins(:users).where(["users.id = ?",current_user.id])
    end
    

end