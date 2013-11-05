class FragmentTypeLibraryRelationship < ActiveRecord::Base
  attr_accessible :fragment_type_id, :library_id
  
  belongs_to :fragment_type
  belongs_to :library

end
