module FragmentTypesHelper

  def get_fragment_types_libraries(fragment_types)
    libraries = {}
    fragment_types.each do |id,ft|
      ft.libraries.each {|lib| libraries[lib.id]=lib }
    end
    libraries
  end
  
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
