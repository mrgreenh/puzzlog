class ArticlesController < ApplicationController
  include ArticlesHelper
  include FragmentsHelper
 
  
  #-----------------------------------------------------Privileges
  before_filter :article_create_filter, only:[:new,:create]
  before_filter :article_destroy_filter, only: :destroy
  before_filter :article_edit_filter, only: [:edit, :update]
  before_filter :article_view_filter, only: [:show]
  before_filter :article_publish_filter, only: :publish
  
  def new
    @article = Article.new
    
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @article = Article.new(title: params[:title], user_id: current_user.id)
    if @article.save
      render 'edit'
    else
      render 'new'
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def index
    @articles = current_user.articles.order('updated_at desc').paginate(:page => params[:page], :per_page => 4)
    # TODO togliere i frammenti da qui
    @fragments = current_user.fragments.order('updated_at desc').paginate(:page => params[:page], :per_page => 4) 
    @fragment_types = getFragmentTypes(@fragments)
  end

  def show
    @article = Article.find(params[:id])
  end
  
  def publish
    
  end
  
  private
  
    def article_create_filter
      if not can_create_articles?
        flash[:errors] = "You're not the boss, you can't create articles."
        redirect_to root_path
      end
    end
    
    def article_edit_filter
      if not can_edit_article?
        flash[:errors] = "You can't edit this article"
        redirect_to root_path
      end
    end
    
    def article_destroy_filter
      if not can_destroy_article?
        flash[:errors] = "You can't destroy this article"
        redirect_to root_path
      end
    end
    
    def article_view_filter
      if not can_view_article?
        flash[:errors] = "You can't view this article"
        redirect_to root_path
      end
    end
  
    def article_publish_filter
      if not can_publish_article?
        flash[:errors] = "You can't publish articles"
        redirect_to root_path
      end
    end
    
end
