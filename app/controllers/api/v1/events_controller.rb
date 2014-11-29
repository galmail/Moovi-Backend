class Api::V1::EventsController < Api::BaseController
    
    def index
      @events = Event.where(["custom = ? AND active = ?",false,true])
    end
    
end