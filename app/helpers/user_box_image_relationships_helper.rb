module UserBoxImageRelationshipsHelper
  #privileges
  def can_create_user_box_image_relationships?
     has_role?('superadmin')||has_role?('writer')
  end
end
