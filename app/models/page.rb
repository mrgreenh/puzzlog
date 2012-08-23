class Page < ActiveRecord::Base
  attr_accessible :number, :foreground_color, :background_color, :third_color
  
  belongs_to :article
  has_many :page_fragment_relationships
  has_many :fragments, through: :page_fragment_relationships, source: :fragment
  
end
