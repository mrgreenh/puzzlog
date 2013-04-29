class CreateBags < ActiveRecord::Migration
  def change
    create_table :bags do |t|
      t.string :name
      t.integer :user_id
      t.timestamps
    end
  end
end
