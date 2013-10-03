class CreateMenuEntries < ActiveRecord::Migration
  def change
    create_table :menu_entries do |t|
      t.integer :article_id
      t.integer :order
      t.string :link_type
      t.string :title

      t.timestamps
    end
  end
end
