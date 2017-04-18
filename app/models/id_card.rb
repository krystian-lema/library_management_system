class IdCard < ApplicationRecord

	belongs_to :student

	validates :number, presence: true
	
end
