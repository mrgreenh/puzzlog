module UserRoleRelationshipsHelper
  
  def can_create_user_role_relationships?(user=current_user)
    has_role?('superadmin')
  end
  
  def can_destroy_user_role_relationships?(user=current_user)
    relationship = UserRoleRelationship.find(params[:id])
    can_create_user_role_relationships?&&(relationship.user!=user||relationship.role.name!='superadmin')
  end
  
end
