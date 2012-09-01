class FragmentImagesController < ApplicationController
  def new
    respond_to do |format|
      format.js
    end
  end

  def create
    params[:fragment_resource].each do |image|
      fragment_image = FragmentImage.new(fragment_image_file:image[1]["file"],user_id:current_user.id,description:image[1]["description"])
      if fragment_image.save
        flash[:success] = "Images saved!"
      else
        flash[:success] = nil
        flash[:errors] = "There was a problem saving some of your images, try with some smaller ones."
      end
    end
    
    @fragment_images = current_user.fragment_images.all
    respond_to do |format|
      format.js
      format.html {render 'index'}
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def index
    @fragment_images = current_user.fragment_images.all
    
    respond_to do |format|
      format.html
    end
  end

  def show
  end
end
