class Api::V1::EventsController < Api::BaseController
    
    def index
      @events = Event.where(["custom = ? AND active = ?",false,true])
    end
    
    def create
      params.require(:name)
      event_params = params.permit(:name, :custom, :active)
      event = Event.new(event_params)
      event.created_by = current_user
      if event.save
        render :json=> event.as_json, status: :created
      else
        render :json=> event.errors, status: :unprocessable_entity
      end
    end
    
end