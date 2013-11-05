class CreateFragmentTypeLibraryRelationships < ActiveRecord::Migration
  def change
    create_table :fragment_type_library_relationships do |t|
      t.integer :fragment_type_id
      t.integer :library_id

      t.timestamps
    end
  end
end
