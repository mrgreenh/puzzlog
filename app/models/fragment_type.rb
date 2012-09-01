class FragmentType < ActiveRecord::Base
  attr_accessible :edit_elements, :edit_script, :name, :view_elements, :view_script, :stylesheet, :default_data, :images, :sounds, :videos, :untyped_attachments

  has_many :fragments
  
  def has_images?
    !self.images.nil? && self.images > 0
  end
  
  def has_sounds?
    !self.sounds.nil? && self.sounds > 0
  end
  
  def has_videos?
    !self.videos.nil? && self.videos > 0
  end
  
  def has_untyped_attachments?
    !self.untyped_attachments.nil? && self.untyped_attachments > 0
  end
  
  
end
