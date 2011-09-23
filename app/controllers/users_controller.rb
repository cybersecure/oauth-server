class UsersController < ApplicationController
  def new
    if current_user
      redirect_to_target_or_default root_url, :alert => t('flash.logout_to_signup')
    end
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      cookies[:auth_token] = @user.auth_token
      redirect_to root_url, :notice => t('flash.signed_up')
    else
      render "new"
    end
  end
end
