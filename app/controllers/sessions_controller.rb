class SessionsController < ApplicationController
  def new; end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == Settings.common.checkbox_active ? remember(user) : forget(user)
        redirect_back_or user
      else
        message = t ".error_validate"
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = t ".login_error"
      render :new
    end
  end
  
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
