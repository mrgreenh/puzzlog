class FragmentTypesController < ApplicationController
  include FragmentTypesHelper
  include FragmentsHelper
  
  #------------------------------------------------Privileges
  before_filter :fragment_type_create_filter, only:[:new,:create]
  before_filter :fragment_type_destroy_filter, only: :destroy
  before_filter :fragment_type_edit_filter, only:[:edit,:update]
  
  def index
    @fragment_types =  FragmentType.all
    respond_to do |format|
      format.js
      format.html
    end
  end
  
  def show
    @fragment_type = FragmentType.find(params[:id])
  end
  
  def new
    @fragment_type = FragmentType.new
    #Some example values to help the developer start programming
    @fragment_type.edit_script='$("#fragment_"+fragment.id+"_edit input").val(fragment.data.title);'
    @fragment_type.view_script='$("#fragment_"+fragment.id+"_view p").html(fragment.data.title);'
    @fragment_type.edit_elements='<input type="text" />'
    @fragment_type.view_elements='<p></p>'
    @fragment_type.stylesheet='&.fragment_view{background-color:#55ff77}&.fragment_edit{background-color:#5533ff}'
    @fragment_type.default_data='{"title":"Start coding now!"}'
    
    @sample_images = ""
  end
  
  def create
    @fragment_type = FragmentType.new(name:params[:name],
                                      edit_elements:params[:edit_elements],
                                      view_elements:params[:view_elements],
                                      edit_script:params[:edit_script],
                                      view_script:params[:view_script],
                                      stylesheet:params[:stylesheet],
                                      default_data:params[:default_data],
                                      images:params[:images],
                                      summary_fields:params[:summary_fields],
                                      description:params[:description])
                                      
    @sample_images = params[:sample_images]
    
    if not @fragment_type.save
      render 'new'
    else
      flash[:success] = "Fragment type saved. You can now preview your code."
      render 'edit'
    end
    
  end
  
  def edit
    @fragment_type = FragmentType.find(params[:id])
    @fragment = Fragment.new(fragment_type_id:@fragment_type.id,data:@fragment_type.default_data, user_id:current_user.id)
    @fragment_types = getFragmentTypes([@fragment])
    @fragments = [@fragment.as_json(only:[:id,:name,:fragment_type_id,:data])]
    
    @sample_images = ""
  end
  
  def update
    @fragment_type = FragmentType.find(params[:id])
    @fragment_type.assign_attributes(name:params[:name],
                                      edit_elements:params[:edit_elements],
                                      view_elements:params[:view_elements],
                                      edit_script:params[:edit_script],
                                      view_script:params[:view_script],
                                      stylesheet:params[:stylesheet],
                                      default_data:params[:default_data],
                                      images:params[:images],
                                      summary_fields:params[:summary_fields],
                                      description:params[:description])
    @fragment_type.save
    
    @fragment = Fragment.new(fragment_type_id:@fragment_type.id,data:@fragment_type.default_data, user_id:current_user.id)
    @fragment_types = getFragmentTypes([@fragment])
    @fragments = [@fragment.as_json(only:[:id,:name,:fragment_type_id,:data])]
    
    @sample_images = params[:sample_images]
    
    render 'edit'
  end
  
  def destroy
    @fragment_type = FragmentType.find(params[:id])
    @fragment_type.destroy
    
    flash[:success] = "Fragment type destroyed. Related fragments still in database."
    redirect_to root_path
  end
  
  #privileges
  def fragment_type_create_filter
    can_create_fragment_types?
  end
  
  def fragment_type_destroy_filter
    can_destroy_fragment_type?
  end
  
  def fragment_type_edit_filter
    can_edit_fragment_type?
  end
end