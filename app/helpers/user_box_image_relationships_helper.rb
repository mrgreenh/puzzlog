module UserBoxImageRelationshipsHelper
  #Privileges
  def can_destroy_user_box_image_relationships?(user_box_image_relationship=UserBoxImageRelationship.find(params[:user_box_image_relationships]))
    isowner = true;
    user_box_image_relationship.each do |tmp|
      if not tmp.user == current_user
        isowner = false;
        break
      end
    end
    has_role?('superadmin')||isowner
  end
  
  def can_edit_user_box_image_relationships?(user_box_image_relationship=UserBoxImageRelationship.find(params[:user_box_image_relationships]))
    isowner = true;
    user_box_image_relationship.each do |tmp|
      if not tmp.user == current_user
        isowner = false;
        break
      end
    end
    has_role?('superadmin')||isowner
  end  
  
end
