# coding: utf-8
module FragmentsHelper
  include ArticlesHelper
  
  def getFragmentTypeIcon(fragmentType)
    filename = fragmentType.icon.url(:medium)
  end
  
  def getFragmentTypeIconThumb(fragmentType)
     filename = fragmentType.icon.url(:thumb)
  end
  
  def getFragmentTypes(fragments)
    fragment_types = Hash.new()
    fragments.each do |frag|
      if not frag.nil?
        fragment_types[frag.fragment_type.id] = FragmentType.find(frag.fragment_type.id)
      end
    end
    return fragment_types
  end
  
  def self.streamline(index=0,user=nil)
    if user.nil? then
      first_query = Fragment.where('public=?',true)
    else
      first_query = Fragment.where('public=? AND user_id=?',true,user.id)
    end
    first_query || []
  end

  def any_additional_info_rendered(fragment=@fragment)
    (not @article.nil? and fragment.user!=@article.user) or fragment.articles(@article).any?
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
    has_role?('superadmin') || (has_role?('publisher')&&fragment.user == current_user)
  end
  
end

