class RemoveBioFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :bio
  end

  def down
    add_column :users, :bio, :string
  end
end
