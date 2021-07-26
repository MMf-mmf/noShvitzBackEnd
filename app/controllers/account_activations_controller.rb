class AccountActivationsController < ApplicationController
    #before_create :create_activation_digest
    skip_before_action :authorized, only: [:edit]

    def edit
    
      user = User.find_by(email: params[:email])
      if user && !user.activated? && user.authenticated?(:activation, params[:id])
        user.activate
        log_in user
        
       return render json: {message: "Account activated!"} 
      else
        render json: {message: "Invalid activation link"} 
      end
    end
  
    
    private

  def create_activation_digest
    # Create the token and digest.
  end
end
