class CreatePageFragmentRelationships < ActiveRecord::Migration
  def change
    create_table :page_fragment_relationships do |t|
      t.integer :page_id
      t.integer :fragment_id
      t.integer :ordering_number

      t.timestamps
    end
  end
end
