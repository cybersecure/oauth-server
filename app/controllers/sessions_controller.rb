class SessionsController < ApplicationController
  def new
    if current_user
      redirect_to_target_or_default root_url, :notice => t('flash.already_login')
    end
  end

  def create
    user = User.find_by_username(params[:username])
    if user && user.authenticate(params[:password])
      if params[:remember_me]
        cookies.permanent[:auth_token] = user.auth_token
      else
        cookies[:auth_token] = user.auth_token
      end
      redirect_to_target_or_default root_url, :notice => t('flash.logged_in')
    else
      flash.now[:alert] = t('flash.invalid_credentials')
      render :action => 'new'
    end
  end

  def destroy
    cookies.delete(:auth_token)
    redirect_to root_url, :notice => t('flash.logged_out')
  end
end
