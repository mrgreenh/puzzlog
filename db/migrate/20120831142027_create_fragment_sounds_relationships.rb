class CreateFragmentSoundsRelationships < ActiveRecord::Migration
  def change
    create_table :fragment_sounds_relationships do |t|
      t.integer :fragment_id
      t.integer :fragment_sound_id

      t.timestamps
    end
  end
end
