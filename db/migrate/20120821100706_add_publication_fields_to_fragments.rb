class AddPublicationFieldsToFragments < ActiveRecord::Migration
  def change
    add_column :fragments, :publication_date, :datetime
    add_column :fragments, :public, :boolean
  end
end
