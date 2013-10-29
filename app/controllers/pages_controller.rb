class PagesController < ApplicationController
  include ApplicationHelper
  include PagesHelper
  include FragmentsHelper
  
  before_filter :page_create_filter, only:[:create]
  before_filter :page_destroy_filter, only: :destroy
  before_filter :page_edit_filter, only: [:edit,:assign_theme]
  before_filter :page_view_filter, only: [:show]
  def create
    @article = Article.find(params[:article_id])
    page = @article.pages.build(number:@article.pages.count+1)
    
    if @article.save
      @page = @article.pages.order('number ASC').last
      @fragments = page.ordered_fragments
      @fragment_types = getFragmentTypes(@fragments)
      respond_to do |format|
        format.html {render 'articles/edit'}
        format.js { render 'edit' }
      end
    end
  end
  
  def edit
    @page = Page.find(params[:id])
    @article = @page.article
    @fragments = @page.ordered_fragments
    @fragment_types = getFragmentTypes(@fragments)
    
    respond_to do |format|
      format.html {render 'articles/edit'}
      format.js
    end
  end
  
  def destroy
    page = Page.find(params[:id])
    deleted_page_number = page.number
    @article = page.article
    if page.destroy
      @article.pages.where('number>?', deleted_page_number).each do |p|
        p.number-=1
        p.save
      end
    else
      page.page_fragment_relationships.destroy_all
      page.update_attributes(name:"")
    end
    @page = @article.pages.order('number ASC').first
    @fragments = @page.ordered_fragments
    @fragment_types = getFragmentTypes(@fragments)
    respond_to do |format|
      format.html {render 'articles/edit'}
      format.js { render 'pages/edit' }
    end
  end
  
  def show
    @article = Article.find(params[:id]) if params[:page_id].nil?
    @page = params[:page_id].nil? ? @article.pages.find_by_number(params[:page_number]) : Page.find(params[:page_id])
    @article = @page.article unless params[:page_id].nil?
    
    @fragments = @page.ordered_fragments
    @fragment_types = getFragmentTypes(@fragments)
    
    respond_to do |format|
      format.js { render 'articles/show' }
      format.html { render 'articles/show' }
    end
  end
  
  def assign_theme
    @page = Page.find(params[:id])
    @page.update_attributes(:theme_id => params[:theme_id])
    @page.save
    @article = @page.article
    @fragments = @page.ordered_fragments
    @fragment_types = getFragmentTypes(@fragments)
    respond_to do |format|
      format.js { render 'edit' }
    end
  end

  private
  
    def page_create_filter
      if not can_create_pages?
        flash[:errors] = "Not allowed."
        redirect_to root_path
      end
    end
    
    def page_edit_filter
      if not can_edit_page?
        flash[:errors] = "Not allowed."
        redirect_to root_path
      end
    end
    
    def page_destroy_filter
      if not can_destroy_page?
        flash[:errors] = "Not allowed."
        redirect_to root_path
      end
    end
    
    def page_view_filter
      if not can_view_page?
        flash[:errors] = "Not allowed."
        redirect_to root_path
      end
    end
  
end
