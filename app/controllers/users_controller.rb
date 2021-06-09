class UsersController < ApplicationController
    # skip_before_action :authenticate, only: [:create, :login, :index, :show]
    skip_before_action :authorized, only: [:create, :login]
    def index
        user = User.all
        render json: user
    end

    def create
        # byebug
            user = User.create!(user_sign_up_params)
        if user.valid?
            token = encode_token({ user_id: user.id })
    
            render json: { user: UserSerializer.new(user), token: token }, status: :created
        else
           
            render json: { error: user.errors.full_messages }, status: :bad_request
        end
    end

    def login
        user = User.find_by(email: params[:email])

    #  byebug

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
        # byebug
        render json: @current_user
    end

    # before_action :authenticate
    def profile
        # byebug
        # find that use in the database (happens in the authenticate before_action)
        @current_user.update(name: params[:name], email: params[:email], phoneNumber1: params[:phoneNumber1], phoneNumber2: params[:phoneNumber2])
        render json: @current_user
    end


    

    private
    def user_sign_up_params
        params.require(:user).permit(:name, :email, :phoneNumber1, :phoneNumber2, :password)
    end


end



