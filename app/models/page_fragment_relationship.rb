class PageFragmentRelationship < ActiveRecord::Base
  attr_accessible :fragment_id, :ordering_number, :page_id
  
  belongs_to :fragment
  belongs_to :page
  
end
