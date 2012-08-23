class AddUniqueIndexToArticlesOnTitle < ActiveRecord::Migration
  def change
    add_index :articles, :title, unique:true
  end
end
