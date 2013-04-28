class AddDataToFragmentImages < ActiveRecord::Migration
  def change
    add_column :fragment_images, :data, :hstore
    add_column :fragment_sounds, :data, :hstore
    add_column :fragment_videos, :data, :hstore
    add_column :fragment_untyped_attachments, :data, :hstore
  end
end
