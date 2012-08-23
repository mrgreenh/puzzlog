class AddStylesheetToFragmentTypes < ActiveRecord::Migration
  def change
    add_column :fragment_types, :stylesheet, :text
  end
end
