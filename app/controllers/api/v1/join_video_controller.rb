class Api::V1::JoinVideoController < ApplicationController
    
    def create
      render :json=> { id: 'aaa' }, status: :created
    end
    
end