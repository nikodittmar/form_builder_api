class User < ApplicationRecord
    has_secure_password

    validates :email, presence: true, uniqueness: true, email: true
    validates :username, presence: true, uniqueness: true, length: { in: 1..30 }, format: { without: /\s/, message: "no spaces allowed"}
    validates :password, presence: true, length: { minimum: 8 }
end
