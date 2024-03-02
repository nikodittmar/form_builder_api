class User < ApplicationRecord
    has_secure_password
    has_many :forms, dependent: :destroy

    validates :email, presence: true
    validates :email, uniqueness: true
    validates :email, email: true
    
    validates :username, presence: true
    validates :username, uniqueness: true
    validates :username, length: { in: 1..30 }
    validates :username, format: { without: /\s/, message: "can not have spaces"}
    
    validates :password, presence: true
    validates :password, length: { minimum: 8 }
    validates :password, format: { with: /\A(?=.*\d)/x, message: "must contain a digit" }
    validates :password, format: { with: /\A(?=.*[a-z])/x, message: "must contain a lowercase letter" }
    validates :password, format: { with: /\A(?=.*[A-Z])/x, message: "must contain an uppercase letter" }

    def token
        payload = { :user_id => self.id, :expiration => 7.days.from_now.to_i }
        JWT.encode(payload, Rails.application.secret_key_base)
    end
end
