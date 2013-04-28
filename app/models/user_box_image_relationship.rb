class UserBoxImageRelationship < UserBoxResourceRelationship
  belongs_to :fragment_image, foreign_key: :fragment_resource_id

end
