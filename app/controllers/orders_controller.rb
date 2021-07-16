class OrdersController < ApplicationController
    # skip_before_action :authorized, only: [:index, :show]


    

    def index
        orders = Order.all
        render json: orders.to_json(:include => {
            :order_details => {:only => [:orders_id, :product_id, :quantity, :category_id]}
        }, except:[:created_at, :updated_at])
    end


    def show
        id = params[:id].to_i
        order = Order.where(user_id: id)
        render json: order.to_json(:include => {
            :category => {:only => [:name]}
        })
    end

    # def order
    #     # byebug
    #     order = Order.where(user_id: params[:id])
    #     render json: order 
    # end



    def cart


        userId = params[:user_id]
        categoryId = params[:category_id]
        # byebug
        all_carts = Order.where(cart: true)
        user_carts = all_carts.select{ | cart |cart.user_id == userId && cart.category_id == categoryId}
        if user_carts.empty?
            return render json: {message: 'nothing in cart'}
        end
        cart_details = user_carts[0].order_details
        # .order_details.where("product.category_id" == categoryId)
        render json: cart_details.to_json(:include =>{
                :order => {:only => [:id, :category_id, :submitted, :total, :category_quantity, :case_quantity]},
                :product => {:only => [:name, :company, :price, :category_id, :image, :limit]}
                    }, :except => [:updated_at])
    
    end


    def create
        userId = params[:user_id]
        categoryId = params[:category_id]
        
        all_carts = Order.where(cart: true)
        user_carts = all_carts.select{ | cart |cart.user_id == userId && cart.category_id == categoryId}
        # byebug
        if user_carts.empty?
        order = Order.create!(user_id: params[:user_id], category_id: params[:category_id], fulfilled: false, cart: true, submitted: false , total: 0)
        return render json: order 
        end
        render json: { cart_error: "A cart for this category already exists" }
    end



    def submit
        order = Order.find_by(id: params[:id], )
        reverse_submitted_value = !order.submitted
        order.update!(submitted: reverse_submitted_value)
      
        render json: order
    end

private
# this end point should be triggerd when the user first clicks on the category card
# it is created with cart set to true and status set to false

# def create_params
#     params.permit(:user_id, :category_id)
# end

#user_id: user1.id, category_id: cat1.id, employee_id: nil, total: nil, notes: nil, fulfilled: false, cart: true, submitted: false
#employee_id: nil, total: nil, notes: nil, status: false, cart: true)
end
