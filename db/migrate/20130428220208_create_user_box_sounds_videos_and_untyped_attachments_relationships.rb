class CreateUserBoxSoundsVideosAndUntypedAttachmentsRelationships < ActiveRecord::Migration
 def change
    create_table :user_box_sound_relationships do |t|
      t.integer :fragment_resource_id
      t.integer :user_id
      t.integer :bag_id

      t.timestamps
    end
    create_table :user_box_video_relationships do |t|
      t.integer :fragment_resource_id
      t.integer :user_id
      t.integer :bag_id

      t.timestamps
    end
    create_table :user_box_untyped_attachment_relationships do |t|
      t.integer :fragment_resource_id
      t.integer :user_id
      t.integer :bag_id

      t.timestamps
    end
  end
end
