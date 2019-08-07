class UserMailer < ApplicationMailer
  def account_activation(user)
    @user = user
  end
end
