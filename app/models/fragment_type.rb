class FragmentType < ActiveRecord::Base
  attr_accessible :edit_elements, :edit_script, :name, :view_elements, :view_script, :stylesheet, :default_data, :images, :sounds, :videos, :untyped_attachments, :summary_fields, :description

  has_many :fragments
  
  scope :most_used, :select => 'fragment_types.*',
        :joins => :fragments,
        :group => 'fragment_types.id',
        :order => 'count(*) desc'
  # scope :most_used, find_by_sql('select ft.* from fragments f, fragment_types ft where f.fragment_type_id=ft.id group by ft.id order by count(*) DESC')
  
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
