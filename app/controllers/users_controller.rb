class UsersController < ApplicationController
    # skip_before_action :authenticate, only: [:create, :login, :index, :show]
    skip_before_action :authorized, only: [:create, :login]
    before_action :correct_user, only: [:edit, :update]
    before_action :admin_user, only: [:destroy, :index]


    def index
        # byebug
        user = User.all
        render json: user
    end

    def update
        if @user.update(user_sign_up_params)
            render json: {message: 'Successfully Updated'}
        else
            render json: {message: "Update not successful"}
        end
    end

    def create
        # byebug
            @user = User.create!(user_sign_up_params)
            @user.send_activation_email
        if @user.save
            UserMailer.account_activation(@user).deliver_now
            render json: {message: "Please check your email to activate your account"}
        
        else
            render json: { error: user.errors.full_messages }, status: :bad_request
        end
    end

    def login
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
          token = encode_token({ user_id: user.id })
          # encode_token might need to be issue_token
          # cookies.signed[:jwt] = {value: token, httponly: true}
          
          render json: { user: UserSerializer.new(user), token: token }
          
          render json: user # implicitly run serializer
        else
          render json: { error: "Invalid name or password" }, status: :unauthorized
        end
    end


    # before_action :authenticate
    def autologin
        render json: @current_user
    end


    # before_action :authenticate
    def profile
        # byebug
        # find that use in the database (happens in the authenticate before_action)
        @current_user.update(name: params[:name], email: params[:email], phoneNumber1: params[:phoneNumber1], phoneNumber2: params[:phoneNumber2])
        render json: @current_user
    end


    def destroy
        User.find(params[:id].destroy)
        render json: {message: "account deleted"}
    end


    def correct_user
        @user = User.find(params[:id])
        render json: { error: "Douse not have permission to this rout " }, status: :unauthorized unless current_user?(@user)
    end

    def admin_user
        # byebug
        render json: { error: "Douse not have permission to this rout"}, status: :unauthorized unless current_user.admin?
    end

    

    private
    def user_sign_up_params
        params.require(:user).permit(:name, :email, :phoneNumber1, :phoneNumber2, :password)
    end
end



