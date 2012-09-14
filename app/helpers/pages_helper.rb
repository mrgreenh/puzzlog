module PagesHelper
  def getScssVariables(page)
    scss_variables = "$background_color: #{page.background_color};$foreground_color: #{page.foreground_color};$third_color: #{page.third_color};"
  end
  
  #privileges
  def can_create_pages?(page=nil)
    owner = page.nil?||page.article.user == current_user
    has_role?('superadmin')||(has_role?('writer')&&owner)
  end
  
  def can_destroy_page?(page=Page.find(params[:id]))
    has_role?('superadmin')||page.user == current_user
  end
  
  def can_edit_page?(page=Page.find(params[:id]))
    has_role?('superadmin')||page.user == current_user
  end
  
  def can_view_page?(page=nil)
    if page.nil?
      page = Page.find(params[:page_id]) unless params[:page_id].nil?
      page = Article.find(params[:article_id]).pages.find_by_number(params[:page_number]) unless params[:page_number].nil?
    end
    page.article.public || has_role?('superadmin') || page.user == current_user
  end
end
