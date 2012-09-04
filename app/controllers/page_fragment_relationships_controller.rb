class PageFragmentRelationshipsController < ApplicationController
  def new
    @page = Page.find(params[:page_id])
    @fragment_types = FragmentType.most_used
    
    respond_to do |format|
      format.js
    end
  end

  def create
    @page = Page.find(params[:page_id])
    @fragment = Fragment.create(fragment_type_id:params[:fragment_type_id],data:FragmentType.find(params[:fragment_type_id]).default_data,user_id:current_user.id)
    @page.page_fragment_relationships.build(fragment_id:@fragment.id,
                                            ordering_number:@page.page_fragment_relationships.count+1)
    @page.save
    respond_to do |format|
      format.js
    end
  end

  def destroy
  end

  def edit
  end

  def update
  end
end
