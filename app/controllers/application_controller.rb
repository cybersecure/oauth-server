class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :logged_in?, :redirect_to_target_or_default
  helper :layout

  before_filter :set_user_language

  private 

  def current_user
    if cookies[:auth_token]
      @current_user ||= User.find_by_auth_token!(cookies[:auth_token])
    else
      nil
    end
  end

  def logged_in?
    current_user
  end

  def login_required
    unless logged_in?
      store_target_location
      redirect_to login_url, :alert => "You must first log in before accessing this page."
    end
  end

  def redirect_to_target_or_default(default, *args)
    redirect_to(session[:return_to] || default, *args)
    session[:return_to] = nil
  end

  def store_target_location
    session[:return_to] = request.url
  end

  def set_user_language
    if current_user
		I18n.locale = current_user.language
	else
		I18n.locale = "en"
    end 
  end
end
