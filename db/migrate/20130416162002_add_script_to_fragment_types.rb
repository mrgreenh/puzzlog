class AddScriptToFragmentTypes < ActiveRecord::Migration
  def change
    add_column :fragment_types, :script, :text
  end
end
