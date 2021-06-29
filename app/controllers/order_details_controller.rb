class OrderDetailsController < ApplicationController
    #skip_before_action :authorized, only: [:index, :show, :update, :create]

    def index
        details = OrderDetail.all
        render json: details
    end

    def create
        # lock for user_id, category_id, cart=true
        categoryId = params[:category_id]
        userId = params[:user_id]
        # if a a pruduct axistes in the cart just a to it and do not create a new item
        all_carts = Order.where(cart: true)
        user_carts = all_carts.select{ | cart |cart.user_id == userId && cart.category_id == categoryId}
        cart = user_carts[0]
        # byebug
        cartId = cart.id
        cart_details = cart.order_details
        is_in_cart = cart_details.find_by(product_id: params[:product_id])
        # byebug
        if (is_in_cart)
            updated_item_details = is_in_cart.update!(quantity: (is_in_cart.quantity + params[:quantity]))
            # now update the total on the order table
            
            order = Order.find_by(id: cartId)
            if (order.total === nil)
                order.update!(total: 0)
            end

            order.update!(total: (order.total + (params[:quantity] * Product.find_by(id: params[:product_id]).price)))
            order.update!(case_quantity: order.case_quantity + params[:quantity])
            
            return render json: updated_item_details
        end

        new_item_details = OrderDetail.create!(order_id: cartId, product_id: params[:product_id], quantity: params[:quantity])
            order = Order.find_by(id: cartId)
            if (order.total === nil)
                order.update!(total: 0)
            end
           
            order.update!(total: (order.total + (params[:quantity] * Product.find_by(id: params[:product_id]).price)))
            order.update!(case_quantity: order.case_quantity + params[:quantity])
            order.update!(category_quantity: order.category_quantity + 1)
        
        render json: new_item_details
    end
    #order_id: order1.id, product_id: product6.id, quantity: 6
    # t.integer "category_quantity", default: 0
    # t.integer "case_quantity", default: 0

    def update
        order_item_detail = OrderDetail.find_by(id: params[:id])
        current_quantity = order_item_detail.quantity
        new_quantity = (params[:quantity] - current_quantity)
        order_item_detail.update!(quantity: params[:quantity])
        
        order = Order.find_by(id: order_item_detail.order_id)
        order.update!(case_quantity: order.case_quantity + new_quantity)
        order.update!(total: (order.total + (new_quantity * Product.find_by(id: order_item_detail.product_id).price)))
        render json: order_item_detail
    end

    def destroy
        
        order_item_detail = OrderDetail.find_by(id: params[:id])
        order = Order.find_by(id: order_item_detail.order_id)

        if (order.total === nil)
            order.update!(total: 0)
        end

        order.update!(total: (order.total - (order_item_detail.quantity * Product.find_by(id: order_item_detail.product_id).price)))
        order.update!(case_quantity:  ( order.case_quantity - order_item_detail.quantity ))
        order.update!(category_quantity: ( order.category_quantity - 1) )
        order_item_detail.destroy!
        # byebug
        render json: {amount_remaining: order.order_details.length}
    end



    



    private

    def update_params
        params.permit(:quantity)
    end
end
