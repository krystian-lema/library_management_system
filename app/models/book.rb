class Book < ApplicationRecord
  belongs_to :library
  #belongs_to :borrow
  #belongs_to :borrow_archive
end
