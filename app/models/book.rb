class Book < ApplicationRecord
  belongs_to :library
  has_many :borrows
  #has_one :borrow 
  #belongs_to :borrow_archive
end
