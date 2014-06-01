class StaticPagesController < ApplicationController
include ApplicationHelper
include ArticlesHelper
include FragmentsHelper

  def home
    build_streamline(0)
  end
  
  def streamline
    build_streamline(index = params[:index])
    respond_to do |format|
      format.html { render 'home' }
      format.js { render 'common_partials/infinite_scroll' }
    end
  end
end
