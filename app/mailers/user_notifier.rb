class UserNotifier < ActionMailer::Base
  default :from => "\"Gruvid Team\" <#{ENV['GRUVID_EMAIL']}>"
  
  # send a signup email to the user, pass in the user object that contains the user's email address
  def send_signup_email(user)
    @user = user
    mail(:from => self.gruvid_email, :to => @user.email,:subject => 'Thanks for signing up to Gruvid' )
  end
  
  # invite a guest to join his friend's video
  def send_join_my_video_email(from_user,to_user,video_id)
    @from_user = from_user
    @to_user = to_user
    @video = Video.find(video_id)
    @video_link = "#{ENV['GRUVID_URL']}/www/#/app/join-video/#{video_id}/#{to_user.id}"
    mail(:from => self.gruvid_email, :to => @to_user.email, :subject => "Join #{from_user.name} to create the best video for #{@video.receiver.name}" )
  end
  
  # notify moderator that the video is ready
  def send_video_is_ready_email(moderator,video)
    @moderator = moderator
    @video = video
    mail(:from => self.gruvid_email, :to => @moderator.email, :subject => "Your Video is Ready" )
  end
  
  # notify moderator that the video is rendering
  def send_video_is_rendering_email(moderator,video)
    @moderator = moderator
    @video = video
    mail(:from => self.gruvid_email, :to => @moderator.email, :subject => "Your Video is Rendering" )
  end
  
  def gruvid_email
    "\"Gruvid Team\" <#{ENV['GRUVID_EMAIL']}>"
  end
  
  
end