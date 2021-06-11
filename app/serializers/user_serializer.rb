class UserSerializer < ActiveModel::Serializer
  attributes :name, :email, :address, :phoneNumber1, :phoneNumber2, :id, :order_details, :admin
    
  has_many :order_details, through: :orders
  end
  #  user.order_details.where(:status_code == nil)

