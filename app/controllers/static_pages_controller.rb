class StaticPagesController < ApplicationController
include ApplicationHelper
include ArticlesHelper
include FragmentsHelper

ITEMS_PER_LOAD = 8

  def home
    build_streamline(0,ITEMS_PER_LOAD)
  end
  
  def streamline
    build_streamline(params[:index],ITEMS_PER_LOAD)
    respond_to do |format|
      format.html { render 'home' }
      format.js { render 'common_partials/infinite_scroll' }
    end
  end
end
