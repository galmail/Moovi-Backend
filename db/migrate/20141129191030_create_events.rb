class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events, id: :uuid do |t|
      t.string  :name
      t.string  :pic_url
      
      t.timestamps
    end
  end
end
