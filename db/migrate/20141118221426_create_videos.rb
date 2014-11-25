class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos, id: :uuid do |t|
      t.uuid  :group_id
      t.belongs_to  :moderator, :class_name => 'User'
      t.belongs_to  :receiver, :class_name => 'User'
      
      t.string  :title
      t.string  :url
      t.string  :receiver_name
      t.string  :receiver_email
      t.string  :receiver_mobile
      
      t.timestamps
    end
  end
end
