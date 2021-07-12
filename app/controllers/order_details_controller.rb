

class OrderDetailsController < ApplicationController
    #skip_before_action :authorized, only: [:index, :show, :update, :create]
    before_action :admin_user, only: [:what_to_order]

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



    def what_to_order  # add a cattegory id
        carts = Order.where(cart: true , submitted: true, fulfilled: false, category_id: params[:id]) # this will return a array of orders which fit the description
        #loop over the array and to get the array of order_details for each order
        items = {}
        
        carts.each_with_index do | order, index1 |
            order.order_details.each_with_index do | item_detail, index2 |
                
                if items[item_detail.product.name] != nil
                    items[item_detail.product.name] = items[item_detail.product.name] + item_detail.quantity
                    # byebug
                else 
                    items[item_detail.product.name] = item_detail.quantity
                end
            end     
        end
        # byebug

        # details = carts[0].order_details  # this returns a array of with the item id's and the quantitys

        # in the inner loop add
        if items.length == 0 
            return render json: {message: "no data to found"}
        end
        data = items.to_json #.gsub!(/\"/, '\'')
        
        #byebug
        
       render json: JSON.parse(data)
    end
    


    def admin_user
        # byebug
        render json: { error: "Douse not have permission to this rout"}, status: :unauthorized unless current_user.admin?
    end

    private

    def update_params
        params.permit(:quantity)
    end
end
