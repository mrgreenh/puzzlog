class AddUserIdToMenuEntries < ActiveRecord::Migration
  def up
        add_column :menu_entries, :user_id, :integer
        add_index :menu_entries, [:order, :user_id], :unique => true
  end
  
  def down
        remove_index :menu_entries, :column => [:order, :user_id]
        remove_column :menu_entries, :user_id
  end
end
