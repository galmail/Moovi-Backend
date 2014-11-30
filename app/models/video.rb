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
  
  
end
