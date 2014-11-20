# == Schema Information
#
# Table name: clips
#
#  id         :uuid             not null, primary key
#  user_id    :integer
#  video_id   :integer
#  url        :string(255)
#  message    :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Clip < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :video
end
