class Api::V1::UsersController < Api::BaseController
  
  # Update User's Profile
  def create
    user_data = user_params
    if params[:disconnect_fb_account]
      user_data[:fb_id] = nil
    end
    current_user.update_attributes(user_data)
    render :json => current_user.as_json
  end
  
  private
  
  def user_params
    params[:name] = URI.unescape(params[:name]) if params[:name].present?
    params[:surname] = URI.unescape(params[:surname]) if params[:surname].present?
    params[:city] = URI.unescape(params[:city]) if params[:city].present?
    params.permit(:email,:password,:name,:surname,:photo_url,:date_of_birth,:city,:allow_push_notifications,:allow_dingo_emails,:fb_id,:paypal_account)
  end
  
end