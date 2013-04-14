module SessionsHelper
  
  def sign_in(user)
    if !signed_in? && user.create_remember_token
      cookies.permanent[:remember_token] = user.remember_token
      @current_user = user
    end
  end
  
  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token]) unless cookies[:remember_token].blank?
  end
  
  def current_user?(user)
    user == current_user
  end
  
  def sign_out
    cookies[:remember_token] = nil
    @current_user = nil
  end
  
  def signed_in?
    !current_user.nil?
  end
  
end
