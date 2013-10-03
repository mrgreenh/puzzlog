class MenuEntriesController < ApplicationController
  # GET /menu_entries
  # GET /menu_entries.json
  def index
    @menu_entries = MenuEntry.where('user_id=?',current_user.id).order('menu_entries.order ASC')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @menu_entries }
    end
  end

  # GET /menu_entries/1
  # GET /menu_entries/1.json
  def show
    @menu_entry = MenuEntry.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @menu_entry }
    end
  end

  # GET /menu_entries/new
  # GET /menu_entries/new.json
  def new
    @menu_entry = MenuEntry.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @menu_entry }
    end
  end

  # GET /menu_entries/1/edit
  def edit
    @menu_entry = MenuEntry.find(params[:id])
  end

  # POST /menu_entries
  # POST /menu_entries.json
  def create
    params[:menu_entry][:order] = MenuEntry.find_all_by_user_id(params[:menu_entry][:user_id]).count
    params[:menu_entry][:title] = Article.find(params[:menu_entry][:article_id]).title
    @menu_entry = MenuEntry.new(params[:menu_entry])
    @article    = Article.find(params[:menu_entry][:article_id])

    respond_to do |format|
      if @menu_entry.save #Need to enforce the fact that 'article' type requires an article_id
        flash[:success] = "Article added to your blog's menu!"
        format.html { redirect_to 'index', notice: 'Menu entry was successfully created.' }
        @message = "right"
        format.js
      else
        flash[:error] = "Impossible to add this article to your blog menu."
        @message = "wrong"
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
    @shifted_menu_entries = MenuEntry.where('menu_entries.order>=? AND menu_entries.order<=?',[position_taken,position_left].min,[position_taken,position_left].max)
    @shifted_menu_entries.each do |entry|
      entry.update_attributes(:order => entry.order+increment) unless entry == @moved_menu_entry
    end
    @moved_menu_entry.update_attributes(:order => position_taken)
    @menu_entries = MenuEntry.order('menu_entries.order ASC')
    
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
end
