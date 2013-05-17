class AddMediaFragmentFieldsToFragmentImages < ActiveRecord::Migration
  def change
    add_column :fragment_images, :media_fragment, :string
  end
end
