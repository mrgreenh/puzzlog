class PageFragmentRelationshipsController < ApplicationController
  def new
    @page = Page.find(params[:page_id])
    if params[:from_box]
      @summary_fragments = current_user.fragments.where("stand_alone=?", true).order('updated_at DESC')
      respond_to do |format|
        format.js
      end
    else
      @fragment_types = FragmentType.most_used
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
    end
    @page.page_fragment_relationships.build(fragment_id:@fragment.id,
                                            ordering_number:@page.page_fragment_relationships.count+1)
    @page.save
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @page_fragment_relationship = PageFragmentRelationship.find(params[:id])
    if @page_fragment_relationship.destroy
      respond_to do |format|
        format.js
      end
    end
  end

  def edit
  end

  def update
  end
end
