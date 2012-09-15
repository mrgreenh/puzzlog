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
    @article = Article.create(title: params[:title], user_id: current_user.id)
    @article.pages.build(number:1,foreground_color:"#000000",background_color:"#ffffff",third_color:"#555555")
    if @article.save
      redirect_to edit_article_path(@article)
    else
      flash[:errors] = "There has been some problem creating your article."
      render 'new'
    end
  end

  def edit
    @article = Article.find(params[:id])
    @page = @article.pages.order('number ASC').first
    @fragments = @page.ordered_fragments
    @fragment_types = getFragmentTypes(@fragments)
  end

  def update
    @article = Article.find(params[:id])
    #salvataggio articolo
    @article.update_attributes(title: params[:article][:title].gsub(/\r\n/," "))
    flash[:errors] = @article.errors.messages unless @article.errors.empty?
    #salvataggio frammenti    
    params[:fragments].each do |id, fragment|
      tempFrag = Fragment.find(id)
      tempFrag.update_attributes(data:fragment[:data])
      tempFrag.buildResources(fragment) unless fragment[:images].nil?
    end unless params[:fragments].nil?
    #salvataggio pagine/parametri pagina
    params[:pages].each do |id, page|
      tempPage = Page.find(id)
      tempPage.update_attributes(number:page[:number],
                                  name:page[:name].gsub(/\r\n/," "),
                                  background_color: page[:background_color]||"#ffffff",
                                  foreground_color: page[:foreground_color]||"#000000",
                                  third_color: page[:third_color]||"#555555")
      flash[:errors] = tempPage.errors.messages unless tempPage.errors.empty?
    end
    
    respond_to do |format|
      format.js
    end
  end

  def destroy
    # TODO completare
    @article = Article.find(params[:id])
    if @article.destroy
      respond_to do |format|
        format.js
        format.html do
          flash[:success] = "Your article has been deleted"
          redirect_to articles_path
        end
      end
    end
    
  end

  def index
    @articles = current_user.articles.order('updated_at desc').paginate(:page => params[:page], :per_page => 4)
    
    @fragments = article_summaries_fragments(@articles)
    @fragment_types = getFragmentTypes(@fragments)
  end

  def show
    @article = Article.find(params[:id])
    @page = @article.pages.find_by_number(params[:page_number])||@article.pages.order('number ASC').first
    @fragments = @page.ordered_fragments
    @fragment_types = getFragmentTypes(@fragments)
    
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def publish
    @article = Article.find(params[:id])
    if @article.update_attributes(public:true, publication_date:Time::now)
      flash[:success] = "#{@article.title} published!"
      respond_to do |format|
        format.html do
          @page = @article.pages.find_by_number(params[:page_number])||@article.pages.order('number ASC').first
          @fragments = @page.ordered_fragments
          @fragment_types = getFragmentTypes(@fragments)
          render 'show'
        end
        format.js
      end
    end
  end
  
  def unpublish
    @article = Article.find(params[:id])
    if @article.update_attributes(public:false)
      flash[:success] = "#{@article.title} unpublished!"
      respond_to do |format|
        format.html do
          @page = @article.pages.find_by_number(params[:page_number])||@article.pages.order('number ASC').first
          @fragments = @page.ordered_fragments
          @fragment_types = getFragmentTypes(@fragments)
          render 'show'
        end
        format.js
      end
    end
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
