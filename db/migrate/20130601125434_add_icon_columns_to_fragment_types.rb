class AddIconColumnsToFragmentTypes < ActiveRecord::Migration
  def self.up
    add_attachment :fragment_types, :icon
  end

  def self.down
    remove_attachment :fragment_types, :icon
  end
end
