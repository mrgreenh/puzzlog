class FragmentImagesController < ApplicationController
  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def index
    @fragment_images = current_user.fragment_images
    
    respond_to do |format|
      format.html
    end
  end

  def show
  end
end
