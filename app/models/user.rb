class User < ApplicationRecord

	has_secure_password

	# on create
	validates :username, presence: true, uniqueness: true
	validates :email, presence: true
	validates :password, confirmation: true, length: {minimum: 8}, on: :create
	validates :password_confirmation, presence: true, on: :create

	# on update
	validates :first_name, presence: true, on: :update
	validates :last_name, presence: true, on: :update
	validates :address, presence: true, on: :update
	validates :birth_date, presence: true, on: :update

	# on change password
	validates :password, presence: true, confirmation: true, length: {minimum: 8}, on: :update, if: :validate_password?
	validates :password_confirmation, presence: true, on: :update, if: :validate_password?

	# this is for validate password in update only when change password (not when update other data)
	def validate_password?
  	validate_password == 'true' || validate_password == true
	end
	attr_accessor :validate_password

end
