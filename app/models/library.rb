class Library < ApplicationRecord
	has_many :book

	validates :name, presence: true
	validates :address, presence: true
	validates :description, presence: true
end
