class CreateUserBoxImageRelationship < ActiveRecord::Migration
  def change
    create_table :user_box_image_relationships do |t|
      t.integer :fragment_resource_id
      t.integer :user_id
      t.integer :bag_id

      t.timestamps
    end
  end
end
