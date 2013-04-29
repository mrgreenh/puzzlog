class AddUniqueIndexToUserBagsAndUserBoxResourceRelationship < ActiveRecord::Migration
  def change
    add_index :bags, [:user_id, :name], unique: true
    add_index :user_box_image_relationships, [:user_id, :resource_id], unique: true
    add_index :user_box_video_relationships, [:user_id, :resource_id], unique: true
    add_index :user_box_sound_relationships, [:user_id, :resource_id], unique: true
    add_index :user_box_untyped_attachment_relationships, [:user_id, :resource_id], unique: true, name:'box_untyped_attachment_unique_index_on_user_id_resource_id'
  end
end
