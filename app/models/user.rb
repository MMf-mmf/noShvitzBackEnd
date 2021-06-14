class User < ApplicationRecord
    has_many :orders
    has_many :order_details, through: :orders

    attr_accessor :remember_token, :activation_token

    before_save {  email.downcase! }
    before_create :create_activation_digest

    validates :name, presence: true, length: { maximum: 55 }

    

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 50 },
                        format: { with: VALID_EMAIL_REGEX },
                        uniqueness: true

    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }

    private
    def create_activation_digest
        self.activation_token = User.new_token
        self.activation_digest = User.digest(activation_token)
    end
    
end
