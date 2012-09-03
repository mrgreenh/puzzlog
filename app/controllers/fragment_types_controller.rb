class FragmentTypesController < ApplicationController
  def index
    @fragment_types =  FragmentType.most_used
    
    respond_to do |format|
      format.js
      format.html
    end
  end
  
  def show
    @fragment_type = FragmentType.find(params[:id])
  end
end
