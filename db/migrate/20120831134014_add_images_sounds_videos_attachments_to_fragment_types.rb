class AddImagesSoundsVideosAttachmentsToFragmentTypes < ActiveRecord::Migration
  def change
    add_column :fragment_types, :images, :integer
    add_column :fragment_types, :sounds, :integer
    add_column :fragment_types, :videos, :integer
    add_column :fragment_types, :untyped_attachments, :integer
  end
end
