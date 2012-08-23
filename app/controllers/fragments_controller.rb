class FragmentsController < ApplicationController
  include ApplicationHelper
  include ArticlesHelper
  include FragmentsHelper
  
  #-----------------------------------------------------Privileges
  before_filter :article_create_filter, only:[:new,:create]
  before_filter :article_destroy_filter, only: :destroy
  before_filter :article_edit_filter, only: [:edit, :update]
  before_filter :article_view_filter, only: [:show]
  before_filter :article_publish_filter, only: :publish
  
  def new
    @fragment = Fragment.new(fragment_type_id:params[:fragment_type_id],data:FragmentType.find(params[:fragment_type_id]).default_data)
    @fragment_types = getFragmentTypes([@fragment])
    @fragments = [@fragment.as_json(only:[:id,:name,:fragment_type_id,:data])]
  end

  def create
  end

  def edit
  end

  def update
  end

  def index
  end

  def show
  end
  
  private
    
    def article_create_filter
        if not can_create_articles?
          flash[:errors] = "You're not the boss, you can't create fragments."
          redirect_to root_path
        end
      end
      
      def article_edit_filter
        if not can_edit_article?
          flash[:errors] = "You can't edit this fragment"
          redirect_to root_path
        end
      end
      
      def article_destroy_filter
        if not can_destroy_article?
          flash[:errors] = "You can't destroy this fragment"
          redirect_to root_path
        end
      end
      
      def article_view_filter
        if not can_view_article?
          flash[:errors] = "You can't view this fragment"
          redirect_to root_path
        end
      end
    
      def article_publish_filter
        if not can_publish_article?
          flash[:errors] = "You can't publish fragment"
          redirect_to root_path
        end
      end
end
