class BagsController < ApplicationController
  include BagsHelper
  
  def show
    @resources = resourcesFromBag(params[:id])
    @current_bag_id = params[:id]
    respond_to do |format|
      format.js { render 'box/show' }
      format.html { render 'box/show' }
    end
  end
end
