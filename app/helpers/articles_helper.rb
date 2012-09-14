module ArticlesHelper
  #privileges
  def can_create_articles?
    has_role?('superadmin')||has_role?('writer')
  end
  
  def can_destroy_article?(article=Article.find(params[:id]))
    has_role?('superadmin')||article.user == current_user
  end
  
  def can_edit_article?(article=Article.find(params[:id]))
    has_role?('superadmin')||article.user == current_user
  end
  
  def can_view_article?(article=Article.find(params[:id]))
    article.public || has_role?('superadmin') || article.user == current_user
  end
  
  def can_publish_article?(article=Article.find(params[:id]))
    has_role?('superadmin') || (has_role?('publisher')&&article.user == current_user)
  end
end
