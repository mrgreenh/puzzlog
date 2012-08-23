class StaticPagesController < ApplicationController
  def home
    @articles = Article.order(:updated_at) # TODO sarà publication_date
  end
end
