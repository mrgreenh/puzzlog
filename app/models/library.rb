class Library < ActiveRecord::Base
  attr_accessible :name, :setup

  has_many :fragment_type_library_relationships, dependent: :destroy
  has_many :fragment_types, through: :fragment_type_library_relationships, source: :fragment_type
end
