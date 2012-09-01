class AddAttachmentsToImagesSoundsVideosAndUntypdAttachments < ActiveRecord::Migration
  def up
    add_attachment :fragment_images, :fragment_image_file
    add_attachment :fragment_sounds, :fragment_sound_file
    add_attachment :fragment_videos, :fragment_video_file
    add_attachment :fragment_untyped_attachments, :fragment_untyped_attachment_file
  end
  
  def down
    remove_attachment :fragment_images, :fragment_image_file
    remove_attachment :fragment_sounds, :fragment_sound_file
    remove_attachment :fragment_videos, :fragment_video_file
    remove_attachment :fragment_untyped_attachments, :fragment_untyped_attachment_file
  end
end
