class ChangeDescriptionToNameInUserBags < ActiveRecord::Migration
  def up
    rename_column :user_bags, :description, :name
  end

  def down
    rename_column :user_bags, :name, :description
  end
end
