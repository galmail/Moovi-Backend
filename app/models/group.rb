# == Schema Information
#
# Table name: groups
#
#  id          :uuid             not null, primary key
#  name        :string(255)
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Group < ActiveRecord::Base
  
  has_and_belongs_to_many :users
  has_many  :videos
  
end
