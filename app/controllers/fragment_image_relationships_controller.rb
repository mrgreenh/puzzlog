class FragmentImageRelationshipsController < ApplicationController
  def new
    @fragment_images = current_user.fragment_images.all
    
    respond_to do |format|
      format.js
    end
  end

end
