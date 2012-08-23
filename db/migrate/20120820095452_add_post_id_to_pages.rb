class AddPostIdToPages < ActiveRecord::Migration
  def change
    add_column :pages, :article_id, :integer
  end
end
