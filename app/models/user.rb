# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  name                   :string(255)
#  date_of_birth          :date
#  city                   :string(255)
#  photo_url              :string(255)
#  authentication_token   :string(255)
#  fb_id                  :string(255)
#  first_name             :string(255)
#  last_name              :string(255)
#  gender                 :string(255)
#  locale                 :string(255)
#  invited_by_id          :integer
#  guest                  :boolean          default(FALSE)
#

class User < ActiveRecord::Base
  acts_as_token_authenticatable
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         # :confirmable, :lockable, :timeoutable and :omniauthable

  has_and_belongs_to_many :groups
  has_many    :videos
  has_many    :clips
  has_many    :devices
  belongs_to  :invited_by, :class_name => 'User'
  
end
