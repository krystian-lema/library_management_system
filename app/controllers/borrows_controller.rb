class BorrowsController < ApplicationController
  before_action :authorize
	def index
		@borrows = Borrow.all
		
	end

  def new
  	@borrow = Borrow.new
  end

  #def checkStatus(book_id)
    #if Borrow.exists?(book_id: book_id)
end
