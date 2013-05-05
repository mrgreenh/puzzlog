class BoxController < ApplicationController
include BagsHelper

before_filter :box_view_filter, only: :show

  def show
    @resources = resourcesFromBag
    @current_bag_id = nil
    respond_to do |format|
      format.js
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