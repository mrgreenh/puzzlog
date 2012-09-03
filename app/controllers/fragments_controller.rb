class FragmentsController < ApplicationController
  include ApplicationHelper
  include FragmentsHelper
  
  before_filter :fragment_create_filter, only:[:new,:create]
  before_filter :fragment_destroy_filter, only: :destroy
  before_filter :fragment_edit_filter, only: [:edit, :update]
  before_filter :fragment_view_filter, only: [:show]
  before_filter :fragment_publish_filter, only: [:create,:update]
  
  def new
    @fragment = Fragment.new(fragment_type_id:params[:fragment_type_id],data:FragmentType.find(params[:fragment_type_id]).default_data)
    @fragment_types = getFragmentTypes([@fragment])
    @fragments = [@fragment.as_json(only:[:id,:name,:fragment_type_id,:data])]
  end

  def create
    @fragment = current_user.fragments.build(params[:fragment])
    if params.has_key?(:publish_submit)
      @fragment.public = true
      @fragment.publication_date = Time::now
    end
    
    if @fragment.save
      @fragment.buildResources(params[:fragment_resources]) unless params[:fragment_resources].nil?
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
    if params.has_key?(:publish_submit)
      @fragment.public = true
      @fragment.publication_date = Time::now
      flash[:success] = "Fragment published!"
    elsif params.has_key?(:unpublish_submit)
      flash[:success] = "Fragment unpublished!"
    elsif params.has_key?(:add_puzzle_box)
      flash[:success] = "Fragment added to the puzzle box!"
    end
    
    if @fragment.save
      @fragment.buildResources(params[:fragment_resources]) unless params[:fragment_resources].nil?
      @fragments = [@fragment]
      @fragment_types = getFragmentTypes(@fragments)
      
      respond_to do |format|
        format.js
        format.html {render 'show'}
      end
    else
      flash[:errors] = "An error has occurred. Try again until you get tired of it."
      flash[:success] = nil
      respond_to do |format|
        format.js
        format.html {redirect_to request.referer}
      end
    end
  end

  def index
    @summary_fragments = current_user.fragments.where("stand_alone=?", true).order('updated_at DESC')
  
    respond_to do |format|
      format.html
    end
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
  
  def add_to_puzzle_box
    @fragment = Fragment.find(params[:id])
    
    if @fragment.update_attributes(stand_alone:true)
       respond_to do |format|
          format.js do
            flash[:success] = "This fragment has been added to your puzzle box. Use the form below to choose a name for it, this will help you keep your box organised."
            render 'add_to_puzzle_box'
          end
          format.html do
            @fragments = [@fragment]
            @fragment_types = getFragmentTypes(@fragments)
            flash[:success] = "This fragment has been added to your puzzle box. Use the form below to choose a name for it, this will help you keep your box organised."
            render 'edit'
          end
        end
    else
      flash[:errors] = "There has been a problem, try later."
      rendirect_to request.referer
    end
    
   
  end
  
  private
    
    def fragment_create_filter
        if not can_create_fragments?
          flash[:errors] = "You can't create fragments."
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
        #Qua va detto che il public deve essere diverso da prima, o true se si tratta di un nuovo frammento!
        if !can_publish_fragment?(Fragment.new(params[:fragment]))&&(params.has_key?(:pubish_submit)||fragment_public_state_change?(params)) 
          flash[:errors] = "You can't publish fragments"
          redirect_to root_path
        end
      end
end
