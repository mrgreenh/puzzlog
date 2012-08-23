class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.boolean :public
      t.datetime :publication_date

      t.timestamps
    end
  end
end
