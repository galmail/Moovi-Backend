class RemoveReceiverFieldsFromVideos < ActiveRecord::Migration
  def change
    remove_column :videos, :receiver_name
    remove_column :videos, :receiver_email
    remove_column :videos, :receiver_mobile
  end
end
