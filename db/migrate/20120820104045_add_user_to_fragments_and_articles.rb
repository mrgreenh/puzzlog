class AddUserToFragmentsAndArticles < ActiveRecord::Migration
  def change
    add_column :fragments, :user_id, :integer
    add_column :articles, :user_id, :integer
  end
end
