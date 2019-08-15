class PasswordResetsController < ApplicationController
  before_action :load_user, :valid_user, :check_expiration, only: [:edit, :update]

  def new; end

  def edit; end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t ".reset_email"
      redirect_to root_url
    else
      flash.now[:danger] = t ".email_notfound"
      render :new
    end
  end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, "Sai nha man" )
      render :edit
    elsif @user.update_attributes(user_params)
      log_in @user
      @user.update_attribute(:reset_digest, nil)
      flash[:success] = t ".reset_password_success"
      redirect_to @user
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def load_user
    @user = User.find_by(email: params[:email])
    return if @user
    flash[:warning] = t ".errors.user_notfound"
    redirect_to notfound_path
  end

  # Confirms a valid user.
  def valid_user
    unless @user.activated? && @user.authenticated?(:reset, params[:id])
      redirect_to root_url
    end
  end

   # Checks expiration of reset token.
  def check_expiration
    if @user.password_reset_expired?
      flash[:danger] = t ".error_password_expired"
      redirect_to new_password_reset_url
    end
  end
end
