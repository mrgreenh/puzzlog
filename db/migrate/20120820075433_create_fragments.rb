class CreateFragments < ActiveRecord::Migration
  def change
    create_table :fragments do |t|
      t.integer :fragment_type_id
      t.string :title
      t.boolean :stand_alone
      t.text :data

      t.timestamps
    end
  end
end
