module BagsHelper
  def bagAssignment(params)
     if params[:selected_bag].to_i!=-1 and can_edit_bag?(Bag.find(params[:selected_bag]))
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
  
  def resourcesFromBag(bag_id=nil,resource_type=nil)   #This needs to be all refactored, it sucks!!!
    if not bag_id.nil?
      if resource_type.nil?
        resources = current_user.bags.find(bag_id).box_fragments + current_user.bags.find(bag_id).box_images
      elsif !resource_type.nil? and resource_type=="fragment_image"
        resources = current_user.bags.find(bag_id).box_images
      elsif !resource_type.nil? and resource_type=="fragment"
        resources = current_user.bags.find(bag_id).box_fragments
      end
      return resources
    else
      if resource_type.nil?
        resources = current_user.box_fragments + current_user.box_images
      elsif !resource_type.nil? and resource_type=="fragment_image"
        resources = current_user.box_images
      elsif !resource_type.nil? and resource_type=="fragment"
        resources = current_user.box_fragments
      end
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
  def can_view_bag?(bag=Bag.find(params[:id].to_i))
    has_role?('superadmin')||bag.id!=-1||bag.user == current_user
  end
  
  def can_create_bags?
    has_role?('superadmin')||has_role?('writer')||has_role?('newbie')
  end
  
  def can_destroy_bag?(bag=Bag.find(params[:id].to_i))
    has_role?('superadmin')||bag.id!=-1||bag.user == current_user
  end
  
  def can_edit_bag?(bag=Bag.find(params[:id].to_i))
    has_role?('superadmin')||bag.id!=-1||bag.user == current_user
  end
end
