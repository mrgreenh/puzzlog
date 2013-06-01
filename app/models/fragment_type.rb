class FragmentType < ActiveRecord::Base
  attr_accessible :default_data, :script, :edit_elements, :name, :view_elements,
                  :stylesheet, :images, :sounds, :videos, :untyped_attachments,
                  :summary_fields, :icon, :icon_file_name, :icon_content_type, :icon_file_size, :icon_updated_at,
                  :description
  
  has_many :fragments
  
  validates :name, presence: true, uniqueness: { case_sensitive:false, message:"This name has already been used" }
  validates_presence_of :description
  
  has_attached_file :icon,:styles => {:medium=> "400x400>", :thumb => "128x128>" }, :source_file_options => { :all => '-auto-orient' },
   :default_url=>"/images/application/missing_avatar.png",
   :url => "/images/uploads/fragment_types/:id/:style/:filename",
   :path => ":rails_root/public/images/uploads/fragment_types/:id/:style/:filename"
   
  validates_attachment :icon,
  :content_type => { :content_type => /^image\/(jpg|jpeg|pjpeg|png|x-png|gif)$/, :message => 'file type is not allowed (only jpeg/png/gif images)' },
  :size => { :in => 0..9.megabytes }
  
  scope :most_used, :select => 'fragment_types.*',
        :joins => :fragments,
        :group => 'fragment_types.id',
        :order => 'count(*) desc'
  # scope :most_used, find_by_sql('select ft.* from fragments f, fragment_types ft where f.fragment_type_id=ft.id group by ft.id order by count(*) DESC')
  
  def default_data_to_JSON
    ActiveSupport::JSON.encode(self.default_data)
  end
  
  def default_data=(val)
    if val.kind_of? String
      begin
        val = ActiveSupport::JSON.decode(val)
      rescue
        val = {}
      end
    end
    write_attribute(:default_data, val)
  end
  
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
