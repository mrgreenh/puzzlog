class StaticPagesController < ApplicationController
include ArticlesHelper
include FragmentsHelper

  def home
    @articles = ArticlesHelper.streamline(1,4)
    streamline_fragments = fragments_streamline(1,4)
    @streamline_elements = (@articles+streamline_fragments).sort_by(&:publication_date).reverse
    @index = 2
    
    #per caricare gli script e gli stili
    @fragments = article_summaries_fragments(@articles)+streamline_fragments
    @fragment_types = getFragmentTypes(@fragments+streamline_fragments)
  end
  
  def streamline
    # TODO definire variabile per number default
    # TODO ajax loading, presa number da parametro, fornire number al bottone
    @index = params[:index]
    @articles = ArticlesHelper.streamline(@index,4)
    streamline_fragments = fragments_streamline(@index,4)
    @streamline_elements = (@articles+streamline_fragments).sort_by(&:publication_date).reverse
    
    #per caricare gli script e gli stili
    @fragments = article_summaries_fragments(@articles)+streamline_fragments
    @fragment_types = getFragmentTypes(@fragments)
    
    @index = @index.to_i + 1
    respond_to do |format|
      format.html { render 'home' }
    end
  end
end
