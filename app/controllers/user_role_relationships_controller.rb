class UserRoleRelationshipsController < ApplicationController
  include UserRoleRelationshipsHelper
  
  before_filter :create_filter, only: :create
  before_filter :destroy_filter, only: :destroy
  
  def create
    @user = User.find(params[:user_id])
    @role = Role.find(params[:role_id])
    UserRoleRelationship.create(role_id: @role.id,
                                user_id: @user.id)
    
    respond_to do |format|
      format.html {redirect_to request.referer}
      format.js
    end
  end

  def destroy
    relationship = UserRoleRelationship.find(params[:id])
    @user = User.find(relationship.user_id)
    @role = Role.find(relationship.role_id)
    relationship.destroy
    
    respond_to do |format|
      format.html {redirect_to request.referer}
      format.js
    end
  end
  
  #------------------------------Privileges
  
  def create_filter
    if not can_create_user_role_relationships?
      flash[:errors] ="You can't assign roles!"
      redirect_to root_path
    end
  end
  
  def destroy_filter
    if not can_destroy_user_role_relationships?
      flash[:errors] = "You can't unassign roles!"
      redirect_to root_path
    end
  end
  
end
