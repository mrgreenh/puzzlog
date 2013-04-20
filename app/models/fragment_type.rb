class FragmentType < ActiveRecord::Base
  attr_accessible :default_data, :script, :edit_elements, :name, :view_elements, :stylesheet, :images, :sounds, :videos, :untyped_attachments, :summary_fields, :description
  
  has_many :fragments
  
  validates :name, presence: true, uniqueness: { case_sensitive:false, message:"This name has already been used" }
  
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
