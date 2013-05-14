class UserBoxFragmentRelationshipsController < ApplicationController
  include BagsHelper
  include UserBoxFragmentRelationshipsHelper
  
  before_filter :create_user_box_fragment_relationships_filter, only: [:new, :create]
  
  def new
     @fragment = Fragment.find(params[:id])
     @add_to_box = true
     @new_bag_button = true
     respond_to do |format|
       format.js
     end
  end

  def create
     @fragment = Fragment.find(params[:id])
     bag_id = bagAssignment(params);
     if current_user.user_box_fragment_relationships.create(resource_id:@fragment.id,bag_id:bag_id) and bag_id.to_i>-1
       flash[:success] = "It's kept safe in bag '#{Bag.find(bag_id).name}'."
       @current_bag_id = bag_id #Necessary in case we are adding it to some bag and want to update it
     else
       flash[:success] = "Added to the box!"
       @current_bag_id="none"
     end
     
     respond_to do |format|
      format.js
    end
  end
  
  #privileges
  def create_user_box_fragment_relationships_filter
    if not can_create_user_box_fragment_relationships?
      flash[:errors] = "You don't have the privileges"
      redirect_to root_path
    end
  end
end
