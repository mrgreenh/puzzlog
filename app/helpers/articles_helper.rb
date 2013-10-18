module ArticlesHelper
  def self.streamline(index=1,number=8)
    Article.where('public=?', true).order('publication_date DESC').offset((index.to_i-1)*number.to_i).limit(index.to_i*number.to_i)
  end
  
  def article_summaries_fragments(articles)
    fragments = []
    articles.each do |a|
      if not a.cover_fragment.nil?
        fragments = fragments+[a.cover_fragment]
      end
    end
    return fragments
  end
  
  def in_user_menu(article, user = current_user)
    menu_entry = MenuEntry.where('user_id=? and article_id=?', user, article)
    menu_entry.count>0 ? true : false
  end
  
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
    article.public || has_role?('superadmin') || article.user == current_user || !MenuEntry.find_by_article_id(article.id).nil?
  end
  
  def can_publish_article?(article=Article.find(params[:id]))
    has_role?('superadmin') || (has_role?('publisher')&&article.user == current_user)
  end
end
