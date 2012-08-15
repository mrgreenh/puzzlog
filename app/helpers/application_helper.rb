module ApplicationHelper
  def isBlogInitialized? # TODO devo trovare dove ho usato questo metodo e sostituirlo con quello sotto
    is_blog_initialized?
  end
  def is_blog_initialized?
    User.count != 0
  end
  
  def full_title(custom_title)
    base_title = "Fragments"
    if custom_title.empty?
      base_title
    else
      "#{custom_title} | #{base_title}"
    end
  end
  
  
  #------------------------------------Priviledges
  def has_role?(name, user=current_user)
    user.roles.find_all_by_name(name).any?
  end
  
  def can_modify_blog?
    current_user && is_superadmin?
  end
end
