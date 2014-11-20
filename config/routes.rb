Rails.application.routes.draw do
  
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root 'main#index'
  
  get "/api" => redirect("https://apigee.com/galmail/console/gruvid")
  
  devise_for :users, :controllers => {:registrations => "registrations", :sessions => "sessions"}
  
  namespace :api do
    namespace :v1 do
      resources :videos, defaults: {format: :json}
      resources :clips, defaults: {format: :json}
      
      # resources :users, defaults: {format: :json} do
        # post  'block'
        # post  'report'
      # end
      
      # namespace :payments do
        # post  'store_credit_card'
        # get   'verify_credit_card'
        # post  'authorize_payment'
      # end
      
    end
  end
  
  
  
  

end
