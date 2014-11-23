class AddReadyToVideo < ActiveRecord::Migration
  def change
    add_column  :videos, :ready, :boolean, default: false
  end
end
