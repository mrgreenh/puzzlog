class ChangeFragmentResourceIdToFragmentIdInBoxResourcesRelationships < ActiveRecord::Migration
  def up
    rename_column :user_box_image_relationships, :fragment_resource_id, :resource_id
    rename_column :user_box_sound_relationships, :fragment_resource_id, :resource_id
    rename_column :user_box_video_relationships, :fragment_resource_id, :resource_id
    rename_column :user_box_untyped_attachment_relationships, :fragment_resource_id, :resource_id
  end

  def down
    rename_column :user_box_image_relationships, :resource_id, :fragment_resource_id
    rename_column :user_box_sound_relationships, :resource_id, :fragment_resource_id
    rename_column :user_box_video_relationships, :resource_id, :fragment_resource_id
    rename_column :user_box_untyped_attachment_relationships, :resource_id, :fragment_resource_id
  end
end
