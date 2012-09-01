class AddAttachmentsToImagesSoundsVideosAndUntypdAttachments < ActiveRecord::Migration
  def up
    add_attachment :fragment_images, :file
    add_attachment :fragment_sounds, :file
    add_attachment :fragment_videos, :file
    add_attachment :fragment_untyped_attachments, :file
  end
  
  def down
    remove_attachment :fragment_images, :file
    remove_attachment :fragment_sounds, :file
    remove_attachment :fragment_videos, :file
    remove_attachment :fragment_untyped_attachments, :file
  end
end
