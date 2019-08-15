class UsersController < ApplicationController
  before_action :logged_in_user, except: [:new, :show, :create]
  before_action :load_user, except: [:new, :index, :create]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def new
    @user = User.new  
  end

  def index
    @users = User.user_active.paginate(page: params[:page], per_page: Settings.common.per_page)
  end

  def following
    @title = t ".following_title"
    @users = @user.following.paginate(page: params[:page], per_page: Settings.common.per_page)
    render "show_follow"
  end

  def followers
    @title = t ".followers_title"
    @users = @user.followers.paginate(page: params[:page], per_page: Settings.common.per_page)
    render "show_follow"
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t ".danger_info"
      redirect_to root_url
    else
      render :new
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t ".delete_user_success"
      redirect_to users_url
    else
      flash[:warning] = t ".errors.user_notfound"
      redirect_to notfound_path
    end
  end

  def show
    redirect_to root_path unless @user.activated
    @microposts = @user.microposts.paginate(page: params[:page], per_page: Settings.common.per_page)
  end
  
  def edit; end

  def update 
    if @user.update_attributes(user_params)
      flash[:success] = t ".profile_update_success" 
      redirect_to @user
    else
      render :edit
    end
  end 

  private
  def load_user
    @user = User.find_by(id: params[:id])
    return if @user
    flash[:warning] = t ".errors.user_notfound"
    redirect_to notfound_path
  end
  
  def user_params
    params.require(:user).permit(:name, :email, :password,
      :password_confirmation)
  end

  def correct_user
    redirect_to root_path unless current_user?@user
  end

  def logged_in_user
    unless logged_in?
      save_location
      flash[:danger] = t ".danger_login" 
      redirect_to login_path
    end
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
