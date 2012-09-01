class FragmentImage < FragmentResource
  attr_accessible :fragment_image_file
  
  has_many :fragment_image_relationships, dependent: :destroy
  has_many :fragments, through: :fragment_image_relationships, source: :fragment_image
  
  has_attached_file :fragment_image_file,:styles => {:original=>"1920x1920", :medium => "400x400>", :thumb => "128x128>" }, :source_file_options => { :all => '-auto-orient' },
  :default_url=>"/images/application/missing_avatar.png",
  :url => "/images/uploads/fragment_images/:id/:style/:filename",
  :path => ":rails_root/public/images/uploads/fragment_images/:id/:style/:filename"
  
  validates_attachment :fragment_image_file, :presence => true,
  :content_type => { :content_type => /^image\/(jpg|jpeg|pjpeg|png|x-png|gif)$/, :message => 'file type is not allowed (only jpeg/png/gif images)' },
  :size => { :in => 0..4.megabytes }
  
  belongs_to :user
  
end
