class AddIndexToFragmentData < ActiveRecord::Migration
  def up
    execute "CREATE INDEX fragments_gist_data ON fragments USING GIST(data)"
  end
  
  def down
    execute "DROP INDEX fragments_gist_data"
  end
end
