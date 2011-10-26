class SessionsController < ApplicationController
  def new
    @auth_request ||= params[:auth_request_id]
    if current_user
      if @auth_request.nil?
        redirect_to_target_or_default root_url, :notice => t('flash.already_login')
      else
        redirect_to authorise_app_path(@auth_request)
      end
    end
  end

  def create
    user = User.find_by_username(params[:username])
    @auth_request ||= params[:auth_request_id]
    if user && user.authenticate(params[:password])
      if params[:remember_me]
        cookies.permanent[:auth_token] = user.auth_token
      else
        cookies[:auth_token] = user.auth_token
      end
      if @auth_request.nil?
        redirect_to_target_or_default root_url, :notice => t('flash.logged_in')
      else
        redirect_to authorise_app_path(@auth_request)
      end
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
