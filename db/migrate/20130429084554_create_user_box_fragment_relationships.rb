class CreateUserBoxFragmentRelationships < ActiveRecord::Migration
  def change
    create_table :user_box_fragment_relationships do |t|
      t.integer :resource_id
      t.integer :user_id
      t.integer :bag_id

      t.timestamps
    end
    
    add_index :user_box_fragment_relationships, [:user_id, :resource_id], unique: true, name:'box_fragment_unique_index_on_user_id_resource_id'
  end
end
