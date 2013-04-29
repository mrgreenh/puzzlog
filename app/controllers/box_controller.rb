class BoxController < ApplicationController
  def show
    @box_images = current_user.box_images
  end
end
