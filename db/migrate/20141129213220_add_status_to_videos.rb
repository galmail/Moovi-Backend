class AddStatusToVideos < ActiveRecord::Migration
  def change
    add_column    :videos, :status, :string, default: 'INACTIVE'
    remove_column :videos, :ready
  end
end
