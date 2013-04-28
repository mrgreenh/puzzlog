class CreateBags < ActiveRecord::Migration
  def change
    create_table :user_bags do |t|
      t.string :description
      
      t.timestamps
    end
  end
end
