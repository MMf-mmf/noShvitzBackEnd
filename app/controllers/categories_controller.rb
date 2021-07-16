class CategoriesController < ApplicationController
    skip_before_action :authorized, only: [:index]
    before_action :admin_user, only: [:destroy, :create, :edit, :update]
    
    def index
        categories = Category.all
        render json: categories.to_json(:include => {
            :products => {:only => [:name, :company, :price, :id, :category_id, :image, :limit]}
        }, except:[:created_at, :updated_at]) 
    end

    def categories_bulk_create
        params[:_json].each_with_index do | userArray, index |
            if index != 0
                puts userArray
                puts ""
                puts""

                puts userArray['data'][0]
                puts userArray['data'][1]
                puts userArray['data'][2]
                puts userArray['data'][3]
        
                puts ""
                puts ""
                Category.create(
                    name: userArray['data'][0],
                    category_id: userArray['data'][1],
                    deadline: userArray['data'][2],
                    image: userArray['data'][3],
                )
            end
        end
        
        # byebug
        render json: {message: "Users added Successfully"}
    end

    def create 
      new_category = Category.create!(name: params[:name], category_id: Category.last.id + 1, deadline: params[:deadline], image: params[:picture])
      render json: {message: 'Category Added Successfully'}
    end


    def update
        # byebug
       id = params[:id].to_i
       category = Category.find_by(id: id)
       category.update(name: params[:name], deadline: params[:deadLine], image: params[:picture])
       render json: {message: "Category item was Update Successfully"}
    end


    def delete
            result = Category.where(:id => params[:itemsToDelete][0]).destroy_all
            # byebug
            if result.length < 1
             return render json: {message: "A Error Occurred Trying To Delete This Category"}
            end
            render json: {message: " Deletion was successful"}
    end
    


  
end

