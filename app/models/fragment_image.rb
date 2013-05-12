class FragmentImage < FragmentResource
  
  has_many :fragment_image_relationships, dependent: :destroy
  has_many :fragments, through: :fragment_image_relationships, source: :fragment
  has_many :user_box_image_relationships, foreign_key: :resource_id
  
  has_attached_file :fragment_resource_file,:styles => {:big=>"1920x1920>", :medium => "800x800>", :thumb => "128x128>", :mini =>"60x60>" }, :source_file_options => { :all => '-auto-orient' },
  :default_url=>"/images/application/missing_avatar.png",
  :url => "/images/uploads/fragment_images/:id/:style/:filename",
  :path => ":rails_root/public/images/uploads/fragment_images/:id/:style/:filename"
  
  validates_attachment :fragment_resource_file, presence:true,
  :content_type => { :content_type => /^image\/(jpg|jpeg|pjpeg|png|x-png|gif)$/, :message => 'file type is not allowed (only jpeg/png/gif images)' },
  :size => { :in => 0..9.megabytes }
  
  def as_json(options={})
    result = super(options)
    result[:big] = self.fragment_resource_file.url(:big)
    result[:medium] = self.fragment_resource_file.url(:medium)
    result[:thumb] = self.fragment_resource_file.url(:thumb)
    result[:mini] = self.fragment_resource_file.url(:mini)
    if self.id.nil?
      result[:id] = ''
    end
    result
  end
  
end
