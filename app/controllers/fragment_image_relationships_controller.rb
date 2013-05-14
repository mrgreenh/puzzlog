class FragmentImageRelationshipsController < ApplicationController
  include BagsHelper
  
  def new
    @resources = resourcesFromBag(nil,"fragment_image")
    @current_bag_id = nil
    @resource_type="fragment_image"
    respond_to do |format|
      format.js
    end
  end

end
