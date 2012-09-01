class FragmentImageRelationship < ActiveRecord::Base
  attr_accessible :fragment_id, :fragment_image_id
  
  belongs_to :fragment
  belongs_to :fragment_image
end
