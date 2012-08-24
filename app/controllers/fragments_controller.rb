class FragmentsController < ApplicationController
  include ApplicationHelper
  include FragmentsHelper
  
  # TODO -----------------------------------------------------Privileges
  before_filter :fragment_create_filter, only:[:new,:create]
  before_filter :fragment_destroy_filter, only: :destroy
  before_filter :fragment_edit_filter, only: [:edit, :update]
  before_filter :fragment_view_filter, only: [:show]
  before_filter :fragment_publish_filter, only: [:create,:edit,:update]
  
  def new
    @fragment = Fragment.new(fragment_type_id:params[:fragment_type_id],data:FragmentType.find(params[:fragment_type_id]).default_data)
    @fragment_types = getFragmentTypes([@fragment])
    @fragments = [@fragment.as_json(only:[:id,:name,:fragment_type_id,:data])]
  end

  def create
    @fragment = current_user.fragments.build(params[:fragment])
    if params.has_key?(:save_it_submit)
      logger.debug "Hai salvato!"
      @fragment.stand_alone = true
    elsif params.has_key?(:publish_submit)
      logger.debug "Hai pubblicato!"
      @fragment.public = true
      @fragment.publication_date = Time::now
    end
    
    if @fragment.save
      @fragments = [@fragment]
      @fragment_types = getFragmentTypes(@fragments)
      render 'show'
    else
      flash[:errors] = "There has been a problem saving your fragment"
      render 'edit'
    end
  end

  def edit
    @fragment = Fragment.find(params[:id])
    @fragments = [@fragment]
    @fragment_types = getFragmentTypes(@fragments)
  end

  def update
    @fragment = Fragment.find(params[:id])
    @fragment.assign_attributes(params[:fragment])
    if @fragment.save
      @fragments = [@fragment]
      @fragment_types = getFragmentTypes(@fragments)
      render 'show'
    else
      flash[:errors] = "An error has occurred. Try again until you get tired of it."
      render 'edit'
    end
  end

  def index
  
  end

  def show
    @fragment = Fragment.find(params[:id])
    @fragments = [@fragment]
    @fragment_types = getFragmentTypes(@fragments)
  end
  
  def destroy
    @fragment = Fragment.find(params[:id])
    if @fragment.destroy
      respond_to do |format|
        format.js
        format.html {
          flash[:success] = "Frammento eliminato..."
          redirect_to fragments_path}
      end
    end
  end
  
  private
    
    def fragment_create_filter
        if not can_create_fragments?
          flash[:errors] = "You're not the boss, you can't create fragments."
          redirect_to root_path
        end
      end
      
      def fragment_edit_filter
        if not can_edit_fragment?
          flash[:errors] = "You can't edit this fragment"
          redirect_to root_path
        end
      end
      
      def fragment_destroy_filter
        if not can_destroy_fragment?
          flash[:errors] = "You can't destroy this fragment"
          redirect_to root_path
        end
      end
      
      def fragment_view_filter
        if not can_view_fragment?
          flash[:errors] = "You can't view this fragment"
          redirect_to root_path
        end
      end
    
      def fragment_publish_filter
        if !can_publish_fragment?(Fragment.new(params[:fragment]))&&params.has_key?(:pubish_submit)
          flash[:errors] = "You can't publish fragments"
          redirect_to root_path
        end
      end
end
