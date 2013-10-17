module UserBoxFragmentRelationshipsHelper
  def can_create_user_box_fragment_relationships?(fragment=nil)
    fragment ||= Fragment.find(params[:id])
    (has_role?('superadmin')||has_role?('writer')||has_role?('newbie')) and (fragment.public or fragment.user==current_user)
  end
end
