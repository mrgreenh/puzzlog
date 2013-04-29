class UserBoxFragmentRelationship < UserBoxResourceRelationship
    belongs_to :fragment, foreign_key: :resource_id
end
