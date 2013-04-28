class RemoveFragmentSoundsRelationships < ActiveRecord::Migration
  def up
    drop_table :fragment_sounds_relationships
  end

  def down
    create_table :fragment_sounds_relationships do |t|
      t.integer :fragment_id
      t.integer :fragment_sound_id

      t.timestamps
    end
  end
end
