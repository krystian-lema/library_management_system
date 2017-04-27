class BorrowsController < ApplicationController

	def index
		@borrows = Borrow.all
		
	end

  def new
  	@borrow = Borrow.new
  end

  def create
    if !Borrow.exists?(book_id: params[:book_id])
      @borrow = Borrow.new(book_id: params[:book_id], student_id: current_user.id)
      if @borrow.save
        flash[:success] = "This book is borrow!"   
  	  else
        flash[:error] = "Error. Contact with administrator."
  	  end
    else
      flash[:error] = "This book is already borrowed!"
      redirect_to '/borrows' 
    end
  end

  def addBorrow
    @borrow = Borrow.new
    @borrow.book_id = params[:id]
    @borrow.student_id = current_user.id
    if Borrow.where(:book_id => params[:id]).blank?
      if @borrow.save
        redirect_to '/libraries'
      else
        flash[:error] = "Unkown error! Contact with administrator."
        redirect_to '/borrows'
      end
    else
      flash[:error] = "This book is borrow!"
      redirect_to '/borrows' 
    end
  end

  #def checkStatus(book_id)
    #if Borrow.exists?(book_id: book_id)
end
