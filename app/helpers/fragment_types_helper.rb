module FragmentTypesHelper
  
  #privileges
  def can_create_fragment_types?
    has_role?('superadmin')
  end
  
  def can_destroy_fragment_type?(fragmentType=FragmentType.find(params[:id]))
    has_role?('superadmin')
  end
  
  def can_edit_fragment_type?(fragmentType=FragmentType.find(params[:id]))
    has_role?('superadmin')
  end

end
