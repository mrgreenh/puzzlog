class RemoveStyleAttributesAndAddColorsToPage < ActiveRecord::Migration
  def up
    remove_column :pages, :style_attributes
    add_column :pages, :foreground_color, :string
    add_column :pages, :background_color, :string
    add_column :pages, :third_color, :string
  end

  def down
    remove_column :pages, :third_color
    remove_column :pages, :background_color
    remove_column :pages, :foreground_color
    add_column :pages, :style_attributes, :text
  end
end
