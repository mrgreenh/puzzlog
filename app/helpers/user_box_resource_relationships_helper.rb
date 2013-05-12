module UserBoxResourceRelationshipsHelper
   #Privileges
  def can_destroy_user_box_resource_relationships?(parameters=params)
    isowner = checkMultiplePermissions(parameters)
    has_role?('superadmin')||isowner
  end
  
  def can_edit_user_box_resource_relationships?(parameters=params)
    isowner = checkMultiplePermissions(parameters)
    has_role?('superadmin')||isowner
  end  
  
  def checkMultiplePermissions(parameters)
    user_box_fragment_relationships = user_box_image_relationships = []
    user_box_image_relationships = UserBoxImageRelationship.find(params[:user_box_resource_relationships][:fragment_images]) unless params[:user_box_resource_relationships][:fragment_images].nil?
    user_box_fragment_relationships = UserBoxFragmentRelationship.find(params[:user_box_resource_relationships][:fragments]) unless params[:user_box_resource_relationships][:fragments].nil?
    relationships = user_box_image_relationships + user_box_fragment_relationships
    isowner = true;
    user_box_image_relationships.each do |tmp|
      if not tmp.user == current_user
        isowner = false;
        break
      end
    end
    return isowner
  end
  
end
