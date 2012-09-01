class CreateFragmentVideos < ActiveRecord::Migration
  def change
    create_table :fragment_videos do |t|
      t.string :description

      t.timestamps
    end
  end
end
