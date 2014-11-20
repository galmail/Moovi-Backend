class UserNotifier < ActionMailer::Base
  default :from => "\"Gruvid Team\" <#{ENV['GRUVID_EMAIL']}>"
  
  # send a signup email to the user, pass in the user object that contains the user's email address
  def send_signup_email(user)
    @user = user
    mail(:from => self.gruvid_email, :to => @user.email,:subject => 'Thanks for signing up to Gruvid' )
  end
  
  def gruvid_email
    "\"Gruvid Team\" <#{ENV['GRUVID_EMAIL']}>"
  end
  
  
end