Rails.application.routes.draw do
  
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root 'main#index'
  
  get "/api" => redirect("https://apigee.com/galmail/console/gruvid")
  
  devise_for :users, :controllers => {:registrations => "registrations", :sessions => "sessions"}
  
  namespace :api do
    namespace :v1 do
      resources :videos, defaults: {format: :json} do
        post 'render', :action => 'render_video'
      end
      resources :clips, defaults: {format: :json}
      resources :events, defaults: {format: :json}
      resources :groups, defaults: {format: :json}
      
      # resources :users, defaults: {format: :json} do
        # post  'block'
        # post  'report'
      # end
      
      #namespace :s3_token do
        # get   's3_token'
        # post  'store_credit_card'
        # post  'authorize_payment'
      #end
      get   's3_token', :controller => 's3_token', :action => 'index'
      post  'upload_guest_clip', :controller => 'join_video', :action => 'create'
      post  'video_is_ready', :controller => 'blender', :action => 'create'
    end
  end
  
  
  
  

end
