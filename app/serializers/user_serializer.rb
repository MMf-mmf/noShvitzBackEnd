class UserSerializer < ActiveModel::Serializer
  attributes :name, :email, :address, :phoneNumber1, :phoneNumber2, :id,  :admin, :activated, :employee, :order_details, :orders
  
  has_many :orders
  has_many :order_details, through: :orders
  # has_many :products, through: :orders
  end
  
