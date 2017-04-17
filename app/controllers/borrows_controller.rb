class BorrowsController < ApplicationController

	def index
		@borrows = Borrow.all
	end

  def new
  	@borrow = Borrow.new
  end

  def create
  	#@borrow = Borrow.new(params[{:book_id => 3, :book_id => 2, }])
  	@borrow = Borrow.new(borrow_create_params)
  	if @borrow.save
      redirect_to '/borrows'
  	else
      render 'new'
    
  	end
  end

  private 
  	def borrow_create_params
  		params.permit(:book_id)
  	end

end
