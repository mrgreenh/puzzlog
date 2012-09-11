module PageFragmentRelationshipsHelper
  def can_create_page_fragment_relationship?
    fragment = true
    if !params[:fragment_id].nil?
      fragment = Fragment.find(params[:fragment_id]).user == current_user
    end
    has_role?('superadmin')||(Page.find(params[:page_id]).user==current_user&&fragment)
  end
  
  def can_destroy_page_fragment_relationship?(page_fragment_relationship=PageFragmentRelationship.find(params[:id]))
    has_role?('superadmin')||page_fragment_relationship.user == current_user
  end
  
  def can_edit_page_fragment_relationship?(page_fragment_relationship=PageFragmentRelationship.find(params[:id]))
    has_role?('superadmin')||page_fragment_relationship.user == current_user
  end
end
