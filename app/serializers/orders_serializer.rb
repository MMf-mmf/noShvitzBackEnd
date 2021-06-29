class OrderSerializer < ActiveModel::Serializer
    attributes :name, :email, :address, :phoneNumber1, :phoneNumber2, :id, :order_details, :admin, :activated
      
    has_many :order_details, through: :orders
    end