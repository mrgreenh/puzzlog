class CreateFragmentUntypedAttachments < ActiveRecord::Migration
  def change
    create_table :fragment_untyped_attachments do |t|
      t.string :description

      t.timestamps
    end
  end
end
