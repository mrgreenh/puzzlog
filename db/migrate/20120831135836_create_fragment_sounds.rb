class CreateFragmentSounds < ActiveRecord::Migration
  def change
    create_table :fragment_sounds do |t|
      t.string :description

      t.timestamps
    end
  end
end
