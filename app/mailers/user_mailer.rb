class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_activation.subject
  
  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Account activation"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
      @user = user
      mail to: user.email, subject: "Password reset"
  end

  def order_confirmation(user)
    @user = user
    mail to: user.email, subject: "Order received"
  end

  def order_cancellation(user)
    @user = user
    mail to: user.email, subject: "Order canceled"
  end

end
