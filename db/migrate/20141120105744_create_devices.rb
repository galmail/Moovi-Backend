class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices, id: :uuid do |t|
      t.belongs_to  :user
      t.string      :brand
      t.string      :model
      t.string      :os
      t.string      :app_version
      t.string      :uid
      t.string      :mobile_number
      t.string      :location
      t.timestamps
    end
  end
end
