class UserBoxVideoRelationship < UserBoxResourceRelationship
  belongs_to :fragment_video, foreign_key: :resource_id

end
