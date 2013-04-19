class AddContentToFragments < ActiveRecord::Migration
  def change
    add_column :fragments, :content, :hstore
  end
end
