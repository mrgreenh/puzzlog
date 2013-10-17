class MenuEntriesController < ApplicationController
  include MenuEntriesHelper
  
  #before_filter :menu_entry_create_filter, only:[:new,:create]
  before_filter :menu_entry_destroy_filter, only: :destroy
  before_filter :menu_entry_edit_filter, only: [:update]


  # GET /menu_entries
  # GET /menu_entries.json
  def index
    @menu_entries = MenuEntry.where('user_id=?',params[:user_id] || current_user.id).order('menu_entries.order ASC') #You should retrieve menus by user

    respond_to do |format|
      format.html
    end
  end

  # POST /menu_entries
  # POST /menu_entries.json
  def create
    params[:menu_entry][:order] = MenuEntry.find_all_by_user_id(params[:menu_entry][:user_id]).count
    params[:menu_entry][:title] = Article.find(params[:menu_entry][:article_id]).title
    @menu_entry = MenuEntry.new(params[:menu_entry])
    @article    = Article.find(params[:menu_entry][:article_id])

    respond_to do |format|
      if can_create_menu_entry? and @article.public and @menu_entry.save #Need to enforce the fact that 'article' type requires an article_id
        flash[:success] = "Article added to your blog's menu!"
        format.html { redirect_to request.referer }
        format.js
      else
        flash[:errors] = "Impossible to add this article to your blog menu. Make sure to publish this article first."
        format.html { redirect_to request.referer }
        format.js
      end
    end
  end

  # PUT /menu_entries/1
  # PUT /menu_entries/1.json
  def update
    @menu_entry = MenuEntry.find(params[:id])

    respond_to do |format|
      if @menu_entry.update_attributes(params[:menu_entry])
        format.html { redirect_to @menu_entry, notice: 'Menu entry was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @menu_entry.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def move
    user_id = params[:user_id] || current_user.id
    @moved_menu_entry = MenuEntry.find(params[:id])
    position_left  = @moved_menu_entry.order
    position_taken = params[:new_order].to_i
    if position_taken<position_left 
      increment = 1
      position_taken = [0,position_taken].max 
    else
     increment = -1 
     position_taken  = [position_taken,MenuEntry.all.count-1].min
    end
    MenuEntry.transaction do
      @moved_menu_entry.update_attributes(:order => -1)
      @shifted_menu_entries = MenuEntry.where('menu_entries.order>=? AND menu_entries.order<=?',[position_taken,position_left].min,[position_taken,position_left].max)
      @shifted_menu_entries.each do |entry|
        entry.update_attributes(:order => entry.order+increment) unless entry == @moved_menu_entry
      end
      @moved_menu_entry.update_attributes(:order => position_taken)
    end
    @menu_entries = MenuEntry.where('user_id = ?', user_id).order('menu_entries.order ASC')
    
    respond_to do |format| 
      format.html { render 'index' }
    end
  end

  # DELETE /menu_entries/1
  # DELETE /menu_entries/1.json
  def destroy
    @menu_entry = MenuEntry.find(params[:id])
    @menu_entry.destroy

    respond_to do |format|
      format.html { redirect_to menu_entries_url }
      format.json { head :no_content }
    end
  end
  
  private
    def menu_entry_create_filter
        if not can_create_menu_entry?
          flash[:errors] = "You can't add this link to your menu."
          redirect_to root_path
        end
      end
      
      def menu_entry_edit_filter
        if not can_edit_menu_entry?
          flash[:errors] = "You can't modify this menu."
          redirect_to root_path
        end
      end
      
      def menu_entry_destroy_filter
        if not can_destroy_menu_entry?
          flash[:errors] = "You can't modify this menu"
          redirect_to root_path
        end
      end
      
      def menu_entry_view_filter
        if not can_view_menu_entry?
          flash[:errors] = "You can't modify this menu"
          redirect_to root_path
        end
      end
end
