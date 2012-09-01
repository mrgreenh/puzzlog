class AddSummaryFieldsToFragment < ActiveRecord::Migration
  def change
    add_column :fragment_types, :summary_fields, :string
  end
end
