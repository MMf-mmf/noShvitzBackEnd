class CategoriesController < ApplicationController
    skip_before_action :authorized, only: [:index]
    before_action :admin_user, only: [:destroy, :create, :edit, :update]
    
    def index
        categories = Category.all
        render json: categories.to_json(:include => {
            :products => {:only => [:name, :company, :price, :id, :category_id, :image]}
        }, except:[:created_at, :updated_at]) 
    end

    def create 
      new_category = Category.create!(name: params[:name], category_id: Category.last.id + 1, deadline: params[:deadline], image: params[:picture])
      render json: {message: 'Category Add Successfully'}
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

