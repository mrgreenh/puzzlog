class UserBoxSoundRelationship < UserBoxResourceRelationship
  belongs_to :fragment_sound, foreign_key: :resource_id

end
