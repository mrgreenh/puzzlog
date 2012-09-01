class CreateFragmentVideoRelationships < ActiveRecord::Migration
  def change
    create_table :fragment_video_relationships do |t|
      t.integer :fragment_id
      t.integer :fragment_video_id

      t.timestamps
    end
  end
end
