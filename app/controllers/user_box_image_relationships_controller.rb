class UserBoxImageRelationshipsController < ApplicationController
  include UserBoxImageRelationshipsHelper
  include BagsHelper
  
  before_filter :destroy_user_box_image_relationships_filter, only: [:destroy_multiple]
  before_filter :edit_user_box_image_relationships_filter, only: [:update]
  
  def edit_multiple
    @add_to_box = true
    @new_bag_button = false
    respond_to do |format|
      format.js
    end
  end
  
  def update_multiple
    bag_id=nil
    bag_id=params[:bag_id] unless params[:bag_id]=="-1"
    if params[:user_box_image_relationships].blank?
      flash[:errors] = "Please use the checkboxes to select the images to be moved."
    elsif moveBoxResources(params[:user_box_image_relationships],params[:bag_id])
      flash[:success] = "Images moved!"
    else
      flash[:errors] = "There has been some problem moving some images."
    end
    @resources = resourcesFromBag(bag_id)
    @current_bag_id = bag_id
    respond_to do |format|
      format.js { render 'bags/show' }
    end
  end
  
  def destroy_multiple
    if params[:user_box_image_relationships].blank?
      flash[:errors] = "Please use the checkboxes to select the images to be removed."
    elsif UserBoxImageRelationship.destroy(params[:user_box_image_relationships])
      flash[:success] = "Images removed!"
    else
      flash[:errors] = "There has been some problem removing the images."
    end
    
    @current_bag_id = params[:bag_id]
    @resources = resourcesFromBag(@current_bag_id.empty??nil:@current_bag_id)
    respond_to do |format|
      format.js { render 'bags/show' }
    end
  end
  
  private
  
    def destroy_user_box_image_relationships_filter
      if params[:user_box_image_relationships].blank? or !can_destroy_user_box_image_relationships?(UserBoxImageRelationship.find(params[:user_box_image_relationships]))
         flash[:errors] = "You don't have the privileges."
         redirect_to root_path
      end
    end
    
    def edit_user_box_image_relationships_filter
      if params[:user_box_image_relationships].blank? or !can_edit_user_box_image_relationships?(UserBoxImageRelationship.find(params[:user_box_image_relationships]))
         flash[:errors] = "You don't have the privileges."
         redirect_to root_path
      end
    end
end
