class CreateFragmentImages < ActiveRecord::Migration
  def change
    create_table :fragment_images do |t|
      t.string :description

      t.timestamps
    end
  end
end
