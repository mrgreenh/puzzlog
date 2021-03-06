class BoxController < ApplicationController
include BagsHelper

before_filter {@multiple_selection=true}
before_filter :box_view_filter, only: :show

  def show
    @resources = resourcesFromBag(params[:id],params[:resource_type])
    @current_bag_id = nil
    @multiple_selection = true
    @add_to_article = params[:add_to_article]
    @page_id = params[:page_id]
    respond_to do |format|
      format.js { render 'bags/show' }
      format.html
    end
  end
  
  private
    def box_view_filter
      if not can_create_bags?
        flash[:errors] = "You need to be a registered user if you want to have a box."
        redirect_to root_path
      end
    end
end