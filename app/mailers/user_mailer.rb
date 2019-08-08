class UserMailer < ApplicationMailer
  def account_activation(user)
    @user = user
  end

  def password_reset(user)
    @user = user
  end
end
