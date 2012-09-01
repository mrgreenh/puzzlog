class CreateFragmentUntypedAttachmentRelationships < ActiveRecord::Migration
  def change
    create_table :fragment_untyped_attachment_relationships do |t|
      t.integer :fragment_id
      t.integer :fragment_untyped_attachment_id

      t.timestamps
    end
  end
end
