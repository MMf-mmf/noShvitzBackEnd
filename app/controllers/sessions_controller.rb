class SessionsController < ApplicationController
  skip_before_action :authorized, only: [:create, :login]

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
      if user && user.authenticate(params[:session][:password])
        render json: { user: UserSerializer.new(user) }   # , status: :created
        reset_session
        log_in user
        else
          render json: {error: "Invalid username or password"}
        end
  end

  def destroy
    
  end

  def autologin
    render json: @current_user
  end

  def logout
    session.delete(:user_id)
    render json: { message: "Logged Out"}
  end
end
