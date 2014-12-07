# == Schema Information
#
# Table name: videos
#
#  id                        :uuid             not null, primary key
#  group_id                  :uuid
#  moderator_id              :integer
#  receiver_id               :integer
#  title                     :string(255)
#  url                       :string(255)
#  created_at                :datetime
#  updated_at                :datetime
#  event_id                  :uuid
#  event_celebration_date    :date
#  clips_submission_deadline :datetime
#  status                    :string(255)      default("INACTIVE")
#  cover                     :string(255)
#

class Video < ActiveRecord::Base
  belongs_to  :group
  belongs_to  :event
  belongs_to  :moderator, :class_name => 'User'
  belongs_to  :receiver, :class_name => 'User'
  has_many    :participants, :class_name => 'User'
  has_many    :clips
  
  # Video.statuses ( eg. Video.where("status <> ?", Video.statuses[:ready]) )
  enum status: {
    inactive:   'INACTIVE', # user has just created a new video, but still needs to complete video info.
    pending:    'PENDING',  # user has completed the info and sent invitations to group, waiting for new clips.
    rendering:  'RENDERING',# user request to render the video
    error:      'ERROR',    # an error ocurred while rendering the video
    ready:      'READY'     # the video was rendered ok and it is ready
  }
  
  # call blender to render the video
  def renderme
    #require 'net/http'
    uri = URI("#{ENV['BLENDER_URL']}/render")
    uri_params = { :output => "\"https://#{ENV['AWS_BUCKET']}.s3.amazonaws.com/videos/#{self.id}/\"", :videos => [] }
    self.clips.each{ |clip| uri_params[:videos] << '"'+clip.url+'"' }
    uri.query = URI.encode_www_form(uri_params)
    res = Net::HTTP.get_response(uri)
    if res.is_a?(Net::HTTPSuccess)
      self.status = Video.statuses[:rendering]
      if self.save
        UserNotifier.send_video_is_rendering_email(self.moderator,self).deliver
        return true
      end
    end
    return false
  end
  
end
