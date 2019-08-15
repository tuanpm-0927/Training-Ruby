class RelationshipsController < ApplicationController
  before_action :logged_in_user
  before_action :load_user, only: :destroy
  before_action :load_user_follow , only: :create
  
  def create
    @user = User.find_by(id: params[:followed_id])
    current_user.follow(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    current_user.unfollow(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  private 
    def load_user_follow
      @user = User.find_by(id: params[:followed_id])
      flash.now[:warning] = t ".user_notfound"
      redirect_to notfound_path if @user.nil?
    end

    def load_user
      @user = User.find_by(id: params[:id])
      flash.now[:warning] = t ".user_notfound"
      redirect_to notfound_path if @user.nil?
    end
end
