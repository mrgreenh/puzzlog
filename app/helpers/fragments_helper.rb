# coding: utf-8
module FragmentsHelper
  include ArticlesHelper
  def fragment_type_icon_path
    fragment_type_icon_path = "/images/application/fragment_type_icons/"
  end
  
  def getFragmentTypeIcon(fragmentType)
    filename = fragment_type_icon_path+fragmentType.name.gsub(/\s+/, "").downcase+".png"
  end
  
  def getFragmentTypeIconThumb(fragmentType)
    filename = fragment_type_icon_path+fragmentType.name.gsub(/\s+/, "").downcase+"_thumb.png"
  end
  
  def getFragmentTypes(fragments)
    fragment_types = Hash.new()
    fragments.each do |frag|
      fragment_types[frag.fragment_type.id] = FragmentType.find(frag.fragment_type.id)
    end
    return fragment_types
  end
  
  #---------------------------------------Privileges
  def can_create_fragments?
    can_create_articles?
  end
  
  def can_destroy_fragment?(fragment=Fragment.find(params[:id]))
    has_role?('superadmin')||fragment.user == current_user
  end
  
  def can_edit_fragment?(fragment=Fragment.find(params[:id]))
    has_role?('superadmin')||fragment.user == current_user
  end
  
  def can_view_fragment?(fragment=Fragment.find(params[:id]))
    fragment.public || has_role?('superadmin') || fragment.user == current_user
  end
  
  def can_publish_fragment?(fragment=Fragment.find(params[:id]))
    has_role?('superadmin') || has_role?('publisher')
  end
  
  def fragment_public_state_change?(params)
    if fragment = Fragment.find_all_by_id(params[:fragment][:id]).first
      return fragment.public != params[:fragment][:public]
    else
      return false
    end
  end
  
end

