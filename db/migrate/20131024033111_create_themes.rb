class CreateThemes < ActiveRecord::Migration
  def change
    create_table :themes do |t|
      t.string :foreground_color
      t.string :background_color
      t.string :third_color
      t.string :fourth_color
      t.text :stylesheet
      t.string :name
      t.string :preview_image

      t.timestamps
    end
  end
end
