module BagsHelper
  def bagAssignment(params)
     if can_edit_bag?(params[:selected_bag])
      bag_id = params[:selected_bag]
     else
       bag_id = "-1";
     end
    
      
    if params[:new_bag_name]
      tmp_bag = current_user.bags.find_by_name(params[:new_bag_name]) || current_user.bags.build(name:params[:new_bag_name])
      bag_id = tmp_bag.id if tmp_bag.save
    end
    
    return bag_id
  end
  
  def resourcesFromBag(bag_id=nil)
    if not bag_id.nil?
      resources = current_user.bags.find(bag_id).box_images + current_user.bags.find(bag_id).box_fragments
      return resources
    else
      resources = current_user.box_images + current_user.box_fragments
      return resources
    end
  end
  
  def moveBoxResources(relationships = params[:user_box_resource_relationships], bag_id)
    success = true
    relationships[:fragment_images].each do |id|
      if not UserBoxImageRelationship.find(id).update_attributes(bag_id:bag_id)
        success = false
      end
    end unless relationships[:fragment_images].nil?
    relationships[:fragments].each do |id|
      if not UserBoxFragmentRelationship.find(id).update_attributes(bag_id:bag_id)
        success = false
      end
    end unless relationships[:fragments].nil?
    return success
  end
  
  def destroyBoxResources(relationships = params[:user_box_resource_relationships])
    UserBoxImageRelationship.destroy(relationships[:fragment_images]) unless relationships[:fragment_images].nil?
    UserBoxFragmentRelationship.destroy(relationships[:fragments]) unless relationships[:fragments].nil?
  end
  
  #privileges
  def can_view_bag?(bag=Bag.find(params[:id]))
    has_role?('superadmin')||bag.user == current_user
  end
  
  def can_create_bags?
    has_role?('superadmin')||has_role?('writer')
  end
  
  def can_destroy_bag?(bag=Bag.find(params[:id]))
    has_role?('superadmin')||bag.user == current_user
  end
  
  def can_edit_bag?(bag=Bag.find(params[:id]))
    has_role?('superadmin')||bag.user == current_user
  end
end
