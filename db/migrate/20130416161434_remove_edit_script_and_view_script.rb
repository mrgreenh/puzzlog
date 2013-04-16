class RemoveEditScriptAndViewScript < ActiveRecord::Migration
  def up
    remove_column :fragment_types, :edit_script
    remove_column :fragment_types, :view_script
  end

  def down
    add_column :fragment_types, :edit_script, :text
    add_column :fragment_types, :view_script, :text
  end
end
