class AddAttachmentsToImagesSoundsVideosAndUntypdAttachments < ActiveRecord::Migration
  def up
    add_attachment :fragment_images, :fragment_resource_file
    add_attachment :fragment_sounds, :fragment_resource_file
    add_attachment :fragment_videos, :fragment_resource_file
    add_attachment :fragment_untyped_attachments, :fragment_resource_file
  end
  
  def down
    remove_attachment :fragment_images, :fragment_resource_file
    remove_attachment :fragment_sounds, :fragment_resource_file
    remove_attachment :fragment_videos, :fragment_resource_file
    remove_attachment :fragment_untyped_attachments, :fragment_resource_file
  end
end
