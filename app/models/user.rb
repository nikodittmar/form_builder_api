class User < ApplicationRecord
    has_secure_password

    validates :email, presence: true, uniqueness: true, email: true
    validates :username, presence: true, uniqueness: true, length: { in: 1..30 }, format: { without: /\s/, message: "no spaces allowed"}
    validates :password, presence: true, length: { minimum: 8 }

    def token
        payload = { :user_id => self.id, :expiration => 7.days.from_now.to_i }
        JWT.encode(payload, Rails.application.secret_key_base)
    end
end
