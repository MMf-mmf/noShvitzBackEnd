class Product < ApplicationRecord
    belongs_to :category, optional: true
    has_many :order_details
    
end
