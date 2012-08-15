class SessionsController < ApplicationController
  include ApplicationHelper
  include SessionsHelper
  
  before_filter :cannot_login, only: [:create, :new]
  
  def new
    
  end
  
  def create
    user = User.find_by_name(params[:name])
    if user && user.authenticate(params[:password])
      sign_in(user)
      flash[:success] = "Bentornato, #{user.name}."
      
      redirect_to root_path
    else
      flash[:errors] = "Wrong username or password!";
      render 'new'
    end
  end
  
  def destroy
    sign_out
    redirect_to root_path
  end
  
  private
    
    def cannot_login
      if signed_in?
        flash[:errors] = "You are already logged in"
        url = root_path
        redirect_to url
      end
    end
  
end
