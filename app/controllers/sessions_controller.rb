class SessionsController < ApplicationController
  skip_before_action :authorized, only: [:create, :login]

  def new
  end

  def create
   
    user = User.find_by(email: params[:session][:email].downcase)
    
      if user && user.authenticate(params[:session][:password])
        if user.activated?
          # byebug
          reset_session
          params[:session][:remember_me] == true ? remember(user) : forget(user)
          log_in user
          render json: { user: UserSerializer.new(user) }   # , status: :created
          else
            render json: {message: "Account not activated, Check your email for the activation link"}
          end
        else
          render json: {error: "Invalid username or password"}
        end
  end

  def destroy
    logout if logged_in?
  end

  def autologin
    render json: @current_user
  end

  # def logout
  #   # session.delete(:user_id)
  #   reset_session
  #   @current_user = nil
  #   render json: { message: "Logged Out"}
  # end

    #Logs out the current user
    def logout
      forget(current_user)
      reset_session
      @current_user = nil
      render json: { message: "Logged Out"}
    end
end
