module MenuEntriesHelper
    #privileges
  def can_view_menu_entry?(user_id = params[:user_id]||current_user)
    has_role?('superadmin')||user_id == current_user.id
  end
  
  def can_create_menu_entry?(user=current_user, link_type='article', article_id=params[:menu_entry][:article_id])
    (has_role?('superadmin')||has_role?('writer')) and (not link_type=='article' or Article.find(article_id).user==user)
  end
  
  def can_destroy_menu_entry?(menu_entry=MenuEntry.find(params[:id]))
    has_role?('superadmin')||MenuEntry.user == current_user
  end
  
  def can_edit_menu_entry?(menu_entry=MenuEntry.find(params[:id]))
    has_role?('superadmin')||menu_entry.user == current_user
  end
end
