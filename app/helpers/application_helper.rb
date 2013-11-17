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

  def base_url
    "puzzlog.herokuapp.com"
  end

  def app_domain
    "herokuapp.com"
  end

  def twitter_id
    "69243134"
  end

  def build_streamline(index=0,count=8,user=nil)
     @articles = ArticlesHelper.streamline(index,(count/2).to_i,user)
     streamline_fragments = fragments_streamline(index,(count/2).to_i,user)
     @streamline_elements = (@articles+streamline_fragments).sort_by(&:publication_date).reverse

     #per caricare gli script e gli stili
     @fragments = article_summaries_fragments(@articles)+streamline_fragments
     @fragment_types = getFragmentTypes(@fragments)

     @index = index.to_i + 1
     @count = count
  end

  def get_customized_menu_user
    #Return the user of which a customized menu has to be rendered by grabbing the present article or fragment or profile page user id
    result = nil
    if @article
      result = @article.user
    elsif @fragment
      result = @fragment.user
    elsif @user
      result = @user
    end
    if current_user != result
      return result
    else
      return nil
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
