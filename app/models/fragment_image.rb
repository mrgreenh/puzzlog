class FragmentImage < FragmentResource

  has_many :fragment_image_relationships, dependent: :destroy
  has_many :fragments, through: :fragment_image_relationships, source: :fragment_image
  
  belongs_to :user
  
end
