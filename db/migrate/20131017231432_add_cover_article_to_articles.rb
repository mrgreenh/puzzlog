class AddCoverArticleToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :cover_fragment_id, :integer
  end
end
