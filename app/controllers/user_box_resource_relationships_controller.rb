class UserBoxResourceRelationshipsController < ApplicationController
  include UserBoxResourceRelationshipsHelper
  include BagsHelper
  
  before_filter {@multiple_selection=true}
  before_filter :destroy_user_box_resource_relationships_filter, only: [:destroy_multiple]
  before_filter :edit_user_box_resource_relationships_filter, only: [:update]
  
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
    if params[:user_box_resource_relationships].blank?
      flash[:errors] = "Please use the checkboxes to select the items to be moved."
    elsif moveBoxResources(params[:user_box_resource_relationships],params[:bag_id])
      flash[:success] = "Items moved!"
    else
      flash[:errors] = "There has been some problem moving some items."
    end
    @resources = resourcesFromBag(bag_id)
    @current_bag_id = bag_id
    respond_to do |format|
      format.js { render 'bags/show' }
    end
  end

  def destroy_multiple
    if params[:user_box_resource_relationships].nil?
      flash[:errors] = "Please use the checkboxes to select the items to be removed."
    else
      destroyBoxResources(params[:user_box_resource_relationships])
      flash[:success] = "Items removed!"
    end
    
    @current_bag_id = params[:bag_id]
    @resources = resourcesFromBag(@current_bag_id.empty??nil:@current_bag_id)
    respond_to do |format|
      format.js { render 'bags/show' }
    end
  end
  
  private
  
    def destroy_user_box_resource_relationships_filter
      if !params[:user_box_resource_relationships].nil? and !can_destroy_user_box_resource_relationships?
         flash[:errors] = "You don't have the privileges."
         redirect_to root_path
      end
    end
    
    def edit_user_box_resource_relationships_filter
      if !params[:user_box_resource_relationships].nil? and !can_edit_user_box_resource_relationships?
         flash[:errors] = "You don't have the privileges."
         redirect_to root_path
      end
    end
end
