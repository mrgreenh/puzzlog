class UserBoxImageRelationship < UserBoxResourceRelationship
  belongs_to :fragment_image, foreign_key: :resource_id
end
