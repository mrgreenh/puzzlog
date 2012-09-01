class AddUserIdToFragmentResources < ActiveRecord::Migration
  def change
    add_column :fragment_images, :user_id, :integer
    add_column :fragment_sounds, :user_id, :integer
    add_column :fragment_videos, :user_id, :integer
    add_column :fragment_untyped_attachments, :user_id, :integer
  end
end
