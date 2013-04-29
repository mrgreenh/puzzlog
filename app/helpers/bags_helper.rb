module BagsHelper
  def bagAssignment(params)
     if can_edit_bag?(params[:selected_bag])
      bag_id = params[:selected_bag]
     else
       bag_id = -1;
     end
    
      
    if params[:new_bag_name]
      tmp_bag = current_user.bags.find_by_name(params[:new_bag_name]) || current_user.bags.build(name:params[:new_bag_name])
      bag_id = tmp_bag.id if tmp_bag.save
    end
    
    return bag_id
  end
  
  #privileges
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
