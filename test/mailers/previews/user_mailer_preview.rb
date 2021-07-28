# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  
  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/account_activation
  def account_activation
    user = User.first
    user.activation_token = User.new_token
    UserMailer.account_activation(user)
  end


  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/password_reset
  def password_reset
    user = User.first
    user.reset_token = User.new_token
    UserMailer.password_reset(user)
  end


# Preview this email at http://localhost:3000/rails/mailers/user_mailer/order_confirmation
def order_confirmation
  user = User.first
  UserMailer.order_confirmation(user)
end


# Preview this email at http://localhost:3000/rails/mailers/user_mailer/order_cancellation
def order_cancellation
  user = User.first
  UserMailer.order_cancellation(user)
end

end
