class FragmentImage < FragmentResource
  
  has_many :fragment_image_relationships, dependent: :destroy
  has_many :fragments, through: :fragment_image_relationships, source: :fragment
  
  has_attached_file :fragment_resource_file,:styles => {:original=>"1920x1920", :medium => "400x400>", :thumb => "128x128>" }, :source_file_options => { :all => '-auto-orient' },
  :default_url=>"/images/application/missing_avatar.png",
  :url => "/images/uploads/fragment_images/:id/:style/:filename",
  :path => ":rails_root/public/images/uploads/fragment_images/:id/:style/:filename"
  
  validates_attachment :fragment_resource_file, :presence => {message:"You didn't specify any image for some fields!"},
  :content_type => { :content_type => /^image\/(jpg|jpeg|pjpeg|png|x-png|gif)$/, :message => 'file type is not allowed (only jpeg/png/gif images)' },
  :size => { :in => 0..4.megabytes }
  
end
