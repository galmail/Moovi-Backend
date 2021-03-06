class SessionsController < Devise::RegistrationsController
  protect_from_forgery with: :null_session
  #acts_as_token_authentication_handler_for User
  #before_action :authenticate_user!
  
  respond_to :json
  
  # login method
  def new
    verify_params
    myuser = User.find_for_authentication({:email => params[:email]})
    if (myuser.valid_password? params[:password] or myuser.authentication_token==params[:auth_token])
      render :json => {
        :success => true,
        :id => myuser.id,
        :name => myuser.name,
        :guest => myuser.guest,
        :email => params[:email],
        :auth_token => myuser.authentication_token,
        :fb_id => myuser.fb_id
      }
    else
      render :json => { :success => false }, status: :unauthorized
    end
  end
  
  def verify_params
    params.permit(:email,:password,:auth_token)
  end
  

end