module FragmentResourcesHelper
  #---------------------------------------Privileges
  #In questo caso non potrò passare i parametri perchè a seconda del controller che usa questi metodi dovrò passare diversi tipi di modello
  def can_create_fragment_resources?
    can_create_articles?
  end
  
  def can_destroy_fragment_resource?(fragment_resource)
    has_role?('superadmin')||fragment_resource.user == current_user
  end
  
  def can_edit_fragment_resource?(fragment_resource)
    has_role?('superadmin')||fragment_resource.user == current_user
  end
  
  def can_view_fragment_resource?(fragment_resource)
    has_role?('superadmin') || fragment_resource.user == current_user || fragment_resource.is_public?
  end
  
end
