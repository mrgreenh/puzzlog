class BoxController < ApplicationController
include BagsHelper

  def show
    @resources = resourcesFromBag
    @current_bag_id = "none"
    respond_to do |format|
      format.js
      format.html
    end
  end
end
