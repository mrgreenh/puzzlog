module UserBoxFragmentRelationshipsHelper
  def can_create_user_box_fragment_relationships?
    has_role?('superadmin')||has_role?('writer')
  end
end
