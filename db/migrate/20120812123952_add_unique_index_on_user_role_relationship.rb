class AddUniqueIndexOnUserRoleRelationship < ActiveRecord::Migration
  def change
    add_index :user_role_relationships, [:user_id,:role_id], unique:true
  end
end
