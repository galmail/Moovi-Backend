class AddDataToEvents < ActiveRecord::Migration
  def change
    add_column  :events, :custom, :boolean, default: false
    add_column  :events, :active, :boolean, default: true
  end
end
