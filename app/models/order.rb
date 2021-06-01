class Order < ApplicationRecord
    belongs_to :users , optional: true
    has_many :products, through: :order_details
    has_many :order_details
    # has_many :categories, through: :order_details
end
