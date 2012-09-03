class AddColumnDescriptionToFragmentTypes < ActiveRecord::Migration
  def change
    add_column :fragment_types, :description, :text
  end
end
