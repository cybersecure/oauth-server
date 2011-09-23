class PasswordResetsController < ApplicationController
  def new
    if current_user
      redirect_to_target_or_default root_url, :notice => "You are already logged in!"
    end
  end

  def create
    user = User.find_by_username(params[:username]) 
    user.send_password_reset if user
    redirect_to_target_or_default root_url, :notice => "Email sent with password reset instructions."
  end

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => "Password reset has expired."
    elsif @user.update_attributes(params[:user])
      @user.password_reset_sent_at = 3.hours.ago
      @user.save
      redirect_to root_url, :notice => "Password has been reset."
    else
      render :edit
    end
  end
end
