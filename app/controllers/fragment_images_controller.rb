class FragmentImagesController < ApplicationController
  include ApplicationHelper
  include FragmentResourcesHelper
  include ArticlesHelper
  include BagsHelper
  
  before_filter :fragment_resource_create_filter, only:[:new,:create,:search_new,:create_from_search]
  before_filter :fragment_resource_destroy_filter, only: :destroy
  before_filter :fragment_resource_edit_filter, only: [:edit, :update]
  before_filter :fragment_resource_view_filter, only: [:show]
  
  def search_new
    @add_to_box = params[:add_to_box]
    
    respond_to do |format|
      format.js
    end
  end
  
  def new
    @add_to_box = params[:add_to_box]
    respond_to do |format|
      format.js
    end
  end

  def create
    @created_images = Hash.new
    params[:fragment_resource].each do |image|
      fragment_image = FragmentImage.new(fragment_resource_file:image[1]["file"],user_id:current_user.id,description:image[1]["description"])
      
      if fragment_image.save
        flash[:success] = "Images saved!"
        params[:add_to_box] = true
        imagesBagAssignment(fragment_image)
        @created_images[fragment_image.id] = fragment_image.as_json(only: [:id,:description])
      else
        flash[:errors] = "There has been some problem, try again."
      end
    end
    
    @fragment_images = current_user.fragment_images.order('updated_at DESC')
    respond_to do |format|
      format.js
    end
  end

  def create_from_search
    @created_images = Hash.new
    params[:search_results].each do |result|
      image = ActiveSupport::JSON.decode(result)
      logger.debug("---------------------------------------------"+image.to_s)
      description = image["description"]
      image.delete("description");
      fragment_image = FragmentImage.new(user_id:current_user.id, description:description, data:image);
      
      if fragment_image.save
        flash[:success] = "Images saved!"
        imagesBagAssignment(fragment_image)
        @created_images[fragment_image.id] = fragment_image.as_json(only: [:id,:description])
      else
        flash[:errors] = "There has been some problem, try again"
      end
    end
    @fragment_images = current_user.fragment_images.order('updated_at DESC')
    respond_to do |format|
      format.js {render 'create'}
    end
  end

  def edit
    @fragment_image = FragmentImage.find(params[:id])
    
    respond_to do |format|
      format.js
    end
  end

  def update
    @fragment_image = FragmentImage.find(params[:id])
    if @fragment_image.update_attributes(params[:fragment_image])
      flash[:success] = "Image updated to \"#{@fragment_image.description}\""
    else
      flash[:errors] = "There has been a problem while updating your images."
    end
    
    @fragment_images = current_user.fragment_images.order('updated_at DESC')
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @fragment_image = FragmentImage.find(params[:id])
    
    if @fragment_image.destroy
      respond_to do |format|
        format.js
        format.html do
          flash[:success] = "Image deleted"
          render 'index'
        end
      end
    end
  end

  def index
    @fragment_images = current_user.fragment_images.paginate(:page => params[:page], :per_page => 15)
    
    respond_to do |format|
      format.html
    end
  end

  def show
  end
  
  private
    
    def imagesBagAssignment(fragment_image)
      if params[:add_to_box]
           bag_id = bagAssignment(params);
           if current_user.user_box_image_relationships.create(resource_id:fragment_image.id,bag_id:bag_id) and bag_id.to_i>-1
             flash[:success] = flash[:success]+" It's kept safe in bag '#{Bag.find(bag_id).name}'."
             @current_bag_id = bag_id #Necessary in case we are adding it to some bag and want to update it
           else
             @current_bag_id="none"
           end
        end
    end
    
    #Privileged
    
    def fragment_resource_create_filter
        if not can_create_fragment_resources?
          flash[:errors] = "You can't upload images."
          redirect_to root_path
        end
      end
      
      def fragment_resource_edit_filter
        if not can_edit_fragment_resource?(FragmentImage.find(params[:id]))
          flash[:errors] = "You can't edit this image."
          redirect_to root_path
        end
      end
      
      def fragment_resource_destroy_filter
        if not can_destroy_fragment_resource?(FragmentImage.find(params[:id]))
          flash[:errors] = "You can't destroy this image."
          redirect_to root_path
        end
      end
      
      def fragment_resource_view_filter
        if not can_view_fragment_resource?(FragmentImage.find(params[:id]))
          flash[:errors] = "You can't view this image."
          redirect_to root_path
        end
      end
end
