class ChangeTitleToNameOnFragments < ActiveRecord::Migration
  def up
    rename_column :fragments, :title, :name
  end

  def down
    rename_column :fragments, :name, :title
  end
end
