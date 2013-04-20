class RemoveTextDataAndAddHstoreData < ActiveRecord::Migration
  def up
    remove_column :fragment_types, :default_data
    add_column :fragment_types, :default_data, :hstore
    remove_column :fragments, :data
    remove_column :fragments, :content
    add_column :fragments, :data, :hstore
  end

  def down
    remove_column :fragments, :data
    add_column :fragments, :data, :text
    add_column :fragments, :content, :hstore
    remove_column :fragment_types, :default_data
    add_column :fragment_types, :default_data, :text
  end
end
