module LibrariesHelper
  def can_edit_libraries?(user=current_user)
   has_role?('superadmin')
  end

end
