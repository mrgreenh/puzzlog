class AddThemeIdToPages < ActiveRecord::Migration
  def change
    add_column :pages, :theme_id, :integer
  end
end
