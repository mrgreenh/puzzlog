class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.integer :number
      t.text :style_attributes

      t.timestamps
    end
  end
end
