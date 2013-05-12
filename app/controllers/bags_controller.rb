class BagsController < ApplicationController
  include BagsHelper
  
  before_filter {@multiple_selection=true}
  before_filter :bag_create_filter, only:[:new,:create]
  before_filter :bag_destroy_filter, only: :destroy
  before_filter :bag_edit_filter, only: [:edit, :update]
  before_filter :bag_view_filter, only: [:show]
  
  def show
    @resources = resourcesFromBag(params[:id])
    @current_bag_id = params[:id]
    respond_to do |format|
      format.js
      format.html
    end
  end
  
  def new
    @bag = current_user.bags.build
    respond_to do |format|
      format.js
    end
  end
  
  def create
    @bag = current_user.bags.build(name:params[:name])
    if @bag.save
      @current_bag_id = @bag.id.to_s
      @resources = resourcesFromBag(@current_bag_id)
      flash[:success] = "Bag #{@bag.name} created!"
      respond_to do |format|
        format.js
      end
    else
      flash[:errors] = "There has been some problem. Try using another name..."
      respond_to do |format|
        format.js { render 'new' }
      end
    end
  end
  
  def edit
    @bag = Bag.find(params[:id])
    @method=:put
    respond_to do |format|
      format.js {render 'new'}
    end
    
  end
  
  def update
    if @bag = Bag.find(params[:id])
      @current_bag_id = @bag.id.to_s
      @resources = resourcesFromBag(@current_bag_id)
      @bag.name=params[:name]
      if @bag.save
        flash[:success] = "Bag renamed!"
      else
        flash[:errors] = "Try using another name"
      end
    end
    respond_to do |format|
      format.js
    end
  end
  
  def destroy
    if Bag.destroy(params[:id])
      @current_bag_id="none"
      flash[:success] = "Bag deleted successfully"
    else
      @current_bag_id=params[:id]
      flash[:error] = "Can't delete this bag"
    end
    respond_to do |format|
        format.html { redirect_to '/box' }
    end
  end
  
  private
    
    def bag_create_filter
        if not can_create_bags?
          flash[:errors] = "You can't create bags."
          redirect_to root_path
        end
      end
      
      def bag_edit_filter
        if not can_edit_bag?
          flash[:errors] = "You can't edit this bag"
          redirect_to root_path
        end
      end
      
      def bag_destroy_filter
        if not can_destroy_bag?
          flash[:errors] = "You can't destroy this bag"
          redirect_to root_path
        end
      end
      
      def bag_view_filter
        if not can_view_bag?
          flash[:errors] = "You can't view this bag"
          redirect_to root_path
        end
      end
  
end
