class RemoveColorFieldsFromPages < ActiveRecord::Migration
  def up
    remove_column :pages, :foreground_color
    remove_column :pages, :third_color
    remove_column :pages, :background_color
  end

  def down
    add_column :pagess, :foreground_color, :string
    add_column :pagess, :background_color, :string
    add_column :pagess, :third_color, :string
  end
end
