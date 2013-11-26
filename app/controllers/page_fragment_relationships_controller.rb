class PageFragmentRelationshipsController < ApplicationController
  include ArticlesHelper
  include PageFragmentRelationshipsHelper
  include FragmentsHelper
  include BagsHelper
  
  #-----------------------------------------------------Privileges
  before_filter :page_fragment_relationship_create_filter, only:[:new,:create]
  before_filter :page_fragment_relationship_destroy_filter, only: :destroy
  before_filter :page_fragment_relationship_edit_filter, only: :update
  
  def new
    @page = Page.find(params[:page_id])
    if params[:from_box]
      @resources = resourcesFromBag(nil,"fragment")
      @current_bag_id = nil
      @resource_type = "fragment"
      @multiple_selection = true
      @add_to_article = params[:add_to_article]
      @page_id = @page.id
      respond_to do |format|
        format.js
      end
    else
      @fragment_types = FragmentType.all
      respond_to do |format|
        format.js
      end
    end
  end

  def create
    @page = Page.find(params[:page_id])
    if params[:fragment_id].nil?
      @fragment = Fragment.create(fragment_type_id:params[:fragment_type_id],data:FragmentType.find(params[:fragment_type_id]).default_data,user_id:current_user.id)
    else
      @fragment = Fragment.find(params[:fragment_id])
      flash[:success] = "Fragment added to the bottom of the page!"
    end
    @page.page_fragment_relationships.build(fragment_id:@fragment.id,
                                            ordering_number:@page.page_fragment_relationships.count+1)
    @page.save
    @fragments = @page.ordered_fragments
    @fragment_types = getFragmentTypes(@fragments)
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @page_fragment_relationship = PageFragmentRelationship.find(params[:id])
    missing_ordering_number = @page_fragment_relationship.ordering_number
    page = @page_fragment_relationship.page
    if @page_fragment_relationship.destroy
      update_ordering_numbers_after(missing_ordering_number, page)
      respond_to do |format|
        format.js
      end
    end
  end

  def update #which actually is just a reordering
    @page_fragment_relationship = PageFragmentRelationship.find(params[:id])
    ordering_number = @page_fragment_relationship.ordering_number
    if params[:move]=='up'&&@page_fragment_relationship.ordering_number>1
      @page_fragment_relationship_2 = PageFragmentRelationship.where('page_id=? AND ordering_number=?',@page_fragment_relationship.page.id,@page_fragment_relationship.ordering_number-1).first
      @page_fragment_relationship_2.update_attributes(ordering_number: ordering_number)
      @page_fragment_relationship.update_attributes(ordering_number: ordering_number-1)
      @page_fragment_relationship.save
      @page_fragment_relationship_2.save
      @fragment1 = @page_fragment_relationship.fragment
      @fragment2 = @page_fragment_relationship_2.fragment
    elsif params[:move]=='down'&&@page_fragment_relationship.ordering_number<@page_fragment_relationship.page.page_fragment_relationships.count
      @page_fragment_relationship_2 = PageFragmentRelationship.where('page_id=? AND ordering_number=?',@page_fragment_relationship.page.id,@page_fragment_relationship.ordering_number+1).first
      @page_fragment_relationship_2.update_attributes(ordering_number: ordering_number)
      @page_fragment_relationship.update_attributes(ordering_number: ordering_number+1)
      @page_fragment_relationship.save
      @page_fragment_relationship_2.save
      @fragment1 = @page_fragment_relationship_2.fragment
      @fragment2 = @page_fragment_relationship.fragment
    end
    
  end
  
  def move_fragment_to_page
    @relationship = PageFragmentRelationship.find(params[:relationship_id])
    page = Page.find(params[:page_id])
    old_page = @relationship.page
    old_ordering_number = @relationship.ordering_number
    logger.debug page.page_fragment_relationships.count+1
    @relationship.update_attributes(page_id:page.id,ordering_number:page.page_fragment_relationships.count+1)
    if @relationship.save
      update_ordering_numbers_after(old_ordering_number, old_page)
      respond_to do |format|
        format.js
      end
    end
  end
  
  private
  
    def page_fragment_relationship_create_filter
      if not can_create_page_fragment_relationship?
        flash[:errors] = "You're not allowed."
        redirect_to root_path
      end
    end
    
    def page_fragment_relationship_edit_filter
      if not can_edit_page_fragment_relationship?
        flash[:errors] = "You can't edit this article"
        redirect_to root_path
      end
    end
    
    def page_fragment_relationship_destroy_filter
      if not can_destroy_page_fragment_relationship?
        flash[:errors] = "You can't destroy this article"
        redirect_to root_path
      end
    end
end
