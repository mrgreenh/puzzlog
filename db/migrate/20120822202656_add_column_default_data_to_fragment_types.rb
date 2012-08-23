class AddColumnDefaultDataToFragmentTypes < ActiveRecord::Migration
  def change
    add_column :fragment_types, :default_data, :text
  end
end
