class User < ApplicationRecord

	has_secure_password

	validates :username, presence: true
	validates :email, presence: true
	validates :password, confirmation: true, length: {minimum: 8}, on: :create
	validates :password_confirmation, presence: true, on: :create

end
