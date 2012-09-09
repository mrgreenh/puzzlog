class AddUniqueIndexToPageFragmentRelationships < ActiveRecord::Migration
  def change
    add_index :page_fragment_relationships, [:fragment_id, :page_id], unique: true
  end
end
