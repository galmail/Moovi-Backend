class AddDataToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.references  :invited_by
      t.boolean     :guest, default: false
    end
  end
end
