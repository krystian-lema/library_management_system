class User < ApplicationRecord

	has_secure_password

	# on create
	validates :username, presence: true, uniqueness: true
	validates :email, presence: true
	validates :password, presence: true, on: :create

	# on create and update
	validates :first_name, presence: true, on: [:create, :update]
	validates :last_name, presence: true, on: [:create, :update]
	validates :address, presence: true, on: [:create, :update]
	validates :birth_date, presence: true, on: [:create, :update]

	# on change password
	validates :password, presence: true, confirmation: true, length: {minimum: 8}, on: :update, if: :validate_password?
	validates :password_confirmation, presence: true, on: :update, if: :validate_password?

	# this is for validate password in update only when change password (not when update other data)
	def validate_password?
  	validate_password == 'true' || validate_password == true
	end
	attr_accessor :validate_password

	def get_role
		return role
	end

end
