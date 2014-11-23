# == Schema Information
#
# Table name: videos
#
#  id              :uuid             not null, primary key
#  group_id        :integer
#  moderator_id    :integer
#  receiver_id     :integer
#  title           :string(255)
#  url             :string(255)
#  receiver_name   :string(255)
#  receiver_email  :string(255)
#  receiver_mobile :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

class Video < ActiveRecord::Base
  belongs_to  :group
  belongs_to  :moderator, :class_name => 'User'
  belongs_to  :receiver, :class_name => 'User'
  has_many    :participators, :class_name => 'User'
  has_many    :clips
  
end
