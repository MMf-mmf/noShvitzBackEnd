class Product < ApplicationRecord
    belongs_to :categories, optional: true
    has_many :order_details
end
