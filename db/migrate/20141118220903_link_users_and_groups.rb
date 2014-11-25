class LinkUsersAndGroups < ActiveRecord::Migration
  def change
    
    create_table :groups_users, id: false do |t|
      t.belongs_to  :user
      t.uuid        :group_id
    end
    
  end
end
