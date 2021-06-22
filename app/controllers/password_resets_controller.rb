class PasswordResetsController < ApplicationController
  skip_before_action :authorized, only: [:create, :new, :edit, :update]
  before_action :get_user,         only: [:edit, :update]
  before_action :valid_user,       only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
    
  end

  def create
    
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      return render json: {message: "A email has bean sent with password reset instructions"}
      else
        render json: {message: "Email address not found"}
    end
  end

  def edit
  
  end

  def update

   if params[:password].empty?
     return render json: {message: "password can not be empty"}

   elsif @user.update(user_params)
     reset_session
     log_in @user
     @user.update_attribute(:reset_digest, nil)
     return render json: {message: "Password has been reset."}
   else
     render json: {message: "invalid password"}
   end  
  end


  private

  def user_params
    
    params.require(:password_reset).permit(:password, :password_confirmation)
  end

  def get_user
    @user = User.find_by(email: params[:email])
  end

  # Confirms a valid user.
  def valid_user
    unless (@user && @user.activated? &&
            @user.authenticated?(:reset, params[:id]))
      render json: {message: 'Error reseting password'}
    end
  end

  # Checks expiration of reset token.
def check_expiration
  if @user.password_reset_expired?
    render json: {message: "Password reset has expired."}
    
  end
end
end
