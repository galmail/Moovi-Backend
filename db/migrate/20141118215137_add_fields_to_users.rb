class AddFieldsToUsers < ActiveRecord::Migration
  
  def change
    add_column :users, :name, :string
    add_column :users, :date_of_birth, :date
    add_column :users, :city, :string
    add_column :users, :photo_url, :string
  end  

end
