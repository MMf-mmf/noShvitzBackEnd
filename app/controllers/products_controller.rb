class ProductsController < ApplicationController
    before_action :admin_user, only: [:destroy, :create, :edit, :update, :index]

    def index
        products = Product.all
        render json: products.to_json(:include => {
            :category => {:only => [:name, :category_id]}
        })
    end

    # categories = Category.all
    # render json: categories.to_json(:include => {
    #     :products => {:only => [:name, :company, :price, :id, :category_id, :image]}
    # }, except:[:created_at, :updated_at]) 


    def show
       product_list = Product.where(category_id: params[:id])
       render json: product_list
    end


    def products_bulk_create
        params[:_json].each_with_index do | userArray, index |
            if index != 0
                # puts userArray
                # puts ""
                # puts ""

                # puts userArray['data'][0]
                # puts userArray['data'][1]
                # puts userArray['data'][2]
                # puts userArray['data'][3]
                # puts userArray['data'][4]
                # puts userArray['data'][5]
                # puts userArray['data'][6]
                # puts ""
                # puts ""
                Product.create(
                    name: userArray['data'][0],
                    company: userArray['data'][1],
                    price: userArray['data'][2],
                    limit: userArray['data'][3],
                    # category_name: userArray['data'][4],
                    category_id: userArray['data'][5],
                    image: userArray['data'][6]
                )
            end
        end
        # byebug
        render json: {message: "Users added Successfully"}
    end


    def create
    
        new_category = Product.create!(name: params[:name], company: params[:company],
                       category_id: params[:category], price: params[:price], limit: params[:limit], image: params[:image])
        render json: {message: 'Product addition was successful'}
    end

    def delete
        result = Product.where(:id => params[:itemsToDelete]).destroy_all
       
        if result.length < 1
         return render json: {message: "A Error Occurred When Trying To Delete "}
        end
        render json: {message: "Deletion was successful"}
    end

    def update
        
        id = params[:id].to_i
        product = Product.find_by(id: id)
        product.update(name: params[:name], company: params[:company], image: params[:image], price: params[:price], limit: params[:limit])
        render json: {message: "Category item was Update Successfully"}
    end
end
