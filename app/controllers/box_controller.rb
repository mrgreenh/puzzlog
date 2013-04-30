class BoxController < ApplicationController
include BagsHelper

  def show
    @resources = resourcesFromBag
    @current_bag_id = "none"
  end
end
