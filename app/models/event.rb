# == Schema Information
#
# Table name: events
#
#  id         :uuid             not null, primary key
#  name       :string(255)
#  pic_url    :string(255)
#  created_at :datetime
#  updated_at :datetime
#  custom     :boolean          default(FALSE)
#  active     :boolean          default(TRUE)
#

class Event < ActiveRecord::Base
  has_many  :videos
end
