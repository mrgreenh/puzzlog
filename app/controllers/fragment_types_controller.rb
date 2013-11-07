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
    #Some example values to help the developer start programming. This should be moved in the model as a 'default' status.
    @fragment_type.script=<<EOF
//viewSelector and editSelector variables contain the ids of the div elements containing the fragment's views
this.initializeView = function(){ //This will be called only once, when the fragment is shown
  
}
this.initializeEdit = function(){ //This will be called only once, when the fragment's editing controls are shown
  
}
this.view = function(){ //Called whenever a user shows the preview tab. It is also called when a user hits "save".
  
}
this.edit = function(){ //Called whenever a user shows the edit tab
  
}
this.save = function(){ //Executed when the user hits save. Can be used for updating the view too
}
EOF
    @fragment_type.edit_elements='<input type="text" />'
    @fragment_type.view_elements='<p></p>'
    @fragment_type.stylesheet='&.fragment_view{background-color:#55ff77}&.fragment_edit{background-color:#5533ff}'
    @fragment_type.default_data='{"title":"Start coding now!"}'
    
    @sample_images = ""
    @fragment_type_editor_menu = true
  end
  
  def create
    @fragment_type = FragmentType.new(name:params[:name],
                                      edit_elements:params[:edit_elements],
                                      view_elements:params[:view_elements],
                                      script:params[:script],
                                      stylesheet:params[:stylesheet],
                                      default_data:params[:default_data],
                                      images:params[:images],
                                      summary_fields:params[:summary_fields],
                                      description:params[:description])
   @fragment_type.icon = params[:icon]
                                      
    @sample_images = params[:sample_images]
    
    if not @fragment_type.save
      flash[:errors] = "Didn't pass validation. May be you didn't enter a name, description and icon, or the name is already used."
      render 'new'
    else
      @fragment = Fragment.new(fragment_type_id:@fragment_type.id,data:@fragment_type.default_data, user_id:current_user.id)
      @fragment_types = getFragmentTypes([@fragment])
      @fragments = [@fragment.as_json(only:[:id,:name,:fragment_type_id,:data])]
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
    @fragment_type_editor_menu = true
  end
  
  def update
    @fragment_type = FragmentType.find(params[:id])
    @fragment_type.assign_attributes(name:params[:name],
                                      edit_elements:params[:edit_elements],
                                      view_elements:params[:view_elements],
                                      script:params[:script],
                                      stylesheet:params[:stylesheet],
                                      default_data:params[:default_data],
                                      images:params[:images],
                                      summary_fields:params[:summary_fields],
                                      description:params[:description])
    @fragment_type.icon = params[:icon] unless !params[:icon]
    @fragment_type.assign_libraries(params[:libraries])
    @fragment_type.save
    
    @fragment = Fragment.new(fragment_type_id:@fragment_type.id,data:@fragment_type.default_data, user_id:current_user.id)
    @fragment_types = getFragmentTypes([@fragment])
    @sample_data   = params[:sample_data]
    @fragment.data = @sample_data
    @fragments = [@fragment.as_json(only:[:id,:name,:fragment_type_id,:data])]
    @sample_images = params[:sample_images]
    
    @fragment_type_editor_menu = true
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
    if not can_create_fragment_types?
      flash[:errors] = "You can't create fragment types"
      redirect_to root_path
    end
  end
  
  def fragment_type_destroy_filter
    if not can_destroy_fragment_type?
      flash[:errors] = "You can't destroy this fragment type"
      redirect_to root_path
    end
  end
  
  def fragment_type_edit_filter
    if not can_edit_fragment_type?
      flash[:errors] = "You can't edit this fragment type"
      redirect_to root_path
    end
  end
end
