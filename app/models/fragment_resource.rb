class FragmentResource < ActiveRecord::Base
  self.abstract_class = true

  attr_accessible :description, :user_id, :fragment_resource_file
  
  validates_presence_of :user_id
  
  belongs_to :user
  
  def is_public?
    self.fragments.where('public=?',true).any?
  end
end