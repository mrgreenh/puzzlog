class UserBoxResourceRelationship < ActiveRecord::Base
  self.abstract_class = true
  
  attr_accessible :resource_id, :user_id, :bag_id
  
  validates_presence_of :user_id,:resource_id,:bag_id
  validates_uniqueness_of :user_id, scope: :resource_id
  
  belongs_to :user
  belongs_to :bag
  
end
