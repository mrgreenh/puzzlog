class FragmentType < ActiveRecord::Base
  attr_accessible :edit_elements, :edit_script, :name, :view_elements, :view_script

  has_many :fragments
  
end
