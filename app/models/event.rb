# == Schema Information
#
# Table name: events
#
#  id            :uuid             not null, primary key
#  name          :string(255)
#  pic_url       :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  custom        :boolean          default(FALSE)
#  active        :boolean          default(TRUE)
#  created_by_id :integer
#

class Event < ActiveRecord::Base
  has_many    :videos
  belongs_to  :created_by, :class_name => 'User'
  
end
