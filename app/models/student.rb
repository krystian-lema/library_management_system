class Student < ApplicationRecord

	belongs_to :user
	has_one :id_card, dependent: :destroy
	has_many :borrow, dependent: :destroy
	has_many :borrow_archive, dependent: :destroy
	
end