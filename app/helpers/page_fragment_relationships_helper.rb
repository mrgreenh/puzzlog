module PageFragmentRelationshipsHelper
  def update_ordering_numbers_after(missing_ordering_number,page)
    page.page_fragment_relationships.where('ordering_number>?',missing_ordering_number).each do |rel|
      rel.ordering_number -= 1
      rel.save
    end
  end
  #------------------------Privileges
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
