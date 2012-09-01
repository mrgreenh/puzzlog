class CreateFragmentImageRelationships < ActiveRecord::Migration
  def change
    create_table :fragment_image_relationships do |t|
      t.integer :fragment_id
      t.integer :fragment_image_id

      t.timestamps
    end
  end
end
