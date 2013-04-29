class UserBoxUntypedAttachmentRelationship < UserBoxResourceRelationship
   belongs_to :fragment_untyped_attachment, foreign_key: :resource_id

end
