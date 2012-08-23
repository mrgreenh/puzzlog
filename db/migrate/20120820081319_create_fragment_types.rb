class CreateFragmentTypes < ActiveRecord::Migration
  def change
    create_table :fragment_types do |t|
      t.string :name
      t.text :edit_script
      t.text :view_script
      t.text :edit_elements
      t.text :view_elements

      t.timestamps
    end
  end
end
