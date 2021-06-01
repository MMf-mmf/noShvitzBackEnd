class CategoriesController < ApplicationController
    skip_before_action :authenticate, only: [:index]
    def index
        categories = Category.all
        render json: categories.to_json(:include => {
            :products => {:only => [:name, :company, :price, :id, :category_id, :image]}
        }, except:[:created_at, :updated_at]) 
    end
end

