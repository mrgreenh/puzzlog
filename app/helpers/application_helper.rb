module ApplicationHelper
  def is_blog_initialized?
    User.count != 0
  end
  
  def full_title(custom_title)
    base_title = "PuzzLog"
    if custom_title.empty?
      base_title
    else
      "#{custom_title} | #{base_title}"
    end
  end
  
  
  #------------------------------------Priviledges
  def has_role?(name, user=current_user)
    !user.nil? && user.roles.find_all_by_name(name).any?
  end
  
  def can_modify_blog?
    current_user && is_superadmin?
  end
end
