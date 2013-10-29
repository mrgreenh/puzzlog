module ThemesHelper
  def can_edit_themes?(user=current_user)
   has_role?('superadmin')
  end
end
