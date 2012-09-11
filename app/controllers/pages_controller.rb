class PagesController < ApplicationController
  include ApplicationHelper
  include PagesHelper
  include FragmentsHelper
  
  # TODO gestire privilegi delle pagine e delle relazioni coi frammenti
  def create
    @article = Article.find(params[:article_id])
    @page = @article.pages.build(number:@article.pages.count+1,foreground_color:"black",background_color:"white",third_color:"#555555")
    
    if @article.save
      @fragments = @page.ordered_fragments
      @fragment_types = getFragmentTypes(@fragments)
      render 'articles/edit'
    end
  end
  
  def edit
    @page = Page.find(params[:id])
    @article = @page.article
    @fragments = @page.ordered_fragments
    @fragment_types = getFragmentTypes(@fragments)
    
    render 'articles/edit'
  end
  
  def update
    
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
      redirect_to edit_article_path(@article)
    end
  end
  
  def show
  end
end
