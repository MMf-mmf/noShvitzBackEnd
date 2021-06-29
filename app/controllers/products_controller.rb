class ProductsController < ApplicationController
    before_action :admin_user, only: [:destroy, :create, :edit, :update]

    def show
       product_list = Product.where(category_id: params[:id])
       render json: product_list
    end


    def create
    
        new_category = Product.create!(name: params[:name], company: params[:company],
                       category_id: params[:category], price: params[:price], limit: params[:limit], image: params[:image])
        render json: {message: 'Product addition was successful'}
    end

    def delete
        result = Product.where(:id => params[:itemsToDelete]).destroy_all
        byebug
        if result.length < 1
         return render json: {message: "A Error Occurred When Trying To Delete "}
        end
        render json: {message: "Dilation was successful"}
    end

    def update
        
    end
end
