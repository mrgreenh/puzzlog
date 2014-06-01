# coding: utf-8
class UsersController < ApplicationController
  include ApplicationHelper
  include UsersHelper
  include ArticlesHelper
  include FragmentsHelper
  
  #--------------------------------------------Priviledges
  before_filter :user_create_filter, only:[:new,:create]
  before_filter :user_destroy_filter, only: :destroy
  before_filter :user_edit_filter, only: [:edit, :update]
  before_filter :user_view_filter, only: [:show]
  
  
  def new
    if @user.nil?
      @user = User.new
    end
    @not_customized_menu = true # quick horrible patch, fix better when it's not late night
    render 'new'
  end

  def create
    @user = User.new(params[:user])
    @user.assign_attributes(name:params[:name],
                    password:params[:password],
                    password_confirmation:params[:password_confirmation],
                    email:params[:email],
                    bio:params[:bio])
                    
    if !is_blog_initialized?
      @user.user_role_relationships.build(role_id:Role.find_by_name('superadmin').id)
    end
    
    if not @user.save
      render 'new'
    else
      flash[:success] = "User #{@user.name} created!"
      sign_in(@user)
      redirect_to user_path(@user)
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    respond_to do |format|
      format.html do
        redirect_to users_path
        flash[:success] = "User #{@user.name} forever on holidays."
      end
      format.js
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.assign_attributes(params[:user])
    @user.assign_attributes(name:params[:name],bio:params[:bio])
    @user_profile = true
    build_streamline(index = params[:index],user = @user)
    if @user.save
      render 'show'
    else
      render 'edit'
    end
  end

  def show
    @user_profile = true
    @user = User.find(params[:id])
    build_streamline(index=params[:index],user=@user)
    respond_to do |format|
      format.html
      format.js { render 'common_partials/infinite_scroll' }
    end
  end
  
  def index
    @users = User.order(:name).paginate(:page => params[:page], :per_page => 10)
  end
  
  private
    
    #--------------------------------------Priviledges
    def user_create_filter
      if not can_create_users?
        flash[:errors] = "You're not the boss, you can't manage users."
        redirect_to root_path
      end
    end
    
    def user_edit_filter
      if not can_edit_user?
        flash[:errors] = "You can't edit this user"
        redirect_to root_path
      end
    end
    
    def user_destroy_filter
      if not can_destroy_user?
        flash[:errors] = "You can't destroy this user"
        redirect_to root_path
      end
    end
    
    def user_view_filter
      if not can_view_user?
        flash[:errors] = "You can't view this user"
        redirect_to root_path
      end
    end
end
