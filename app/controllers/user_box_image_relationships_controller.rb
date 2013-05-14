class UserBoxImageRelationshipsController < ApplicationController
  include BagsHelper
  include UserBoxImageRelationshipsHelper
  
  before_filter :create_user_box_image_relationships_filter, only: [:new, :create]
  
   def new
     @fragment_image = FragmentImage.find(params[:id])
     if @fragment_image.user_box_image_relationships.find_by_user_id(current_user.id).nil?
       @add_to_box = true
       @new_bag_button = true
       respond_to do |format|
         format.js
       end
    else
      flash[:success] = "This image is already in your box"
      respond_to do |format|
        format.js {render 'common_partials/flash_messages_popup'}
      end
    end
  end

  def create
     @fragment_image = FragmentImage.find(params[:id])
     bag_id = bagAssignment(params);
     if current_user.user_box_image_relationships.create(resource_id:@fragment_image.id,bag_id:bag_id) and bag_id.to_i>-1
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
  
  private
    def create_user_box_image_relationships_filter
      if not can_create_user_box_image_relationships?
        flash[:errors] = "You don't have the privileges"
        redirect_to root_path
      end
    end
end
