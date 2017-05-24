class Borrow < ApplicationRecord
  belongs_to :book
  belongs_to :student

  #in month
  def max_borrow_time
  	return 6
  end
end
