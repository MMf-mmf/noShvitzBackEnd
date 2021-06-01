class UserSerializer < ActiveModel::Serializer
    attributes :name, :email, :address, :ghoneNumber1, :ghoneNumber2, :id, :order_details
    
    has_many :order_details, through: :orders
  end
  #  user.order_details.where(:status_code == nil)