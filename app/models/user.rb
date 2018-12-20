class User < ApplicationRecord

	has_secure_password

	has_one :student, required: false, dependent: :destroy

	# on create
	validates :username, presence: true, uniqueness: true
	validates :email, presence: true
	validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } 
	validates :password, presence: true, on: :create

	# on create and update
	validates :first_name, presence: true, on: [:create, :update]
	validates :last_name, presence: true, on: [:create, :update]
	validates :address, presence: true, on: [:create, :update]
	validates :birth_date, presence: true, on: [:create, :update]
	validates :id_card_number, presence: true, on: :create, if: :create_student?

	# on change password
	validates :password, presence: true,
		length: {minimum: 8, message: "Hasło musi mieć co najmniej 8 znaków."}, on: :update, if: :validate_password?
	validates :password_confirmation, presence: true, on: :update, if: :validate_password?

	# this is for validate password in update only when change password (not when update other data)
	def validate_password?
  	validate_password == 'true' || validate_password == true
	end
	attr_accessor :validate_password

	def create_student?
  	create_student == 'true' || create_student == true
	end
	attr_accessor :create_student

	def get_role
		return role
	end

	def get_role_polish_name
		if role == "librarian"
			return "Bibliotekarz"
		else
			return role.to_s.upcase
		end
	end

  def self.search(search)
    #where("first_name LIKE ?", "%#{search}%")
    where("last_name LIKE ?", "%#{search}%")
  end

end
