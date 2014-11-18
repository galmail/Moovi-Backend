class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups, id: :uuid do |t|
      t.string :name
      t.string :description
      
      t.timestamps
    end
  end
end
