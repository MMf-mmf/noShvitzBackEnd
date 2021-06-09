class User < ApplicationRecord
    has_many :orders
    has_many :order_details, through: :orders
    
    before_save {  email.downcase! }
    validates :name, presence: true, length: { maximum: 255 }

    

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 50 },
                        format: { with: VALID_EMAIL_REGEX },
                        uniqueness: true

    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }
end
