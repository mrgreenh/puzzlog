class UserBoxResourceRelationship < ActiveRecord::Base
  self.abstract_class = true
  
  attr_accessible :fragment_resource_id, :user_id, :bag_id
  
  validates_presence_of :user_id,:fragment_resource_id,:bag_id
  
  belongs_to :user
  belongs_to :bag
  
end
