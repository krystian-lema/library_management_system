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
        flash[:danger] = "Error. Contact with administrator."
  	  end
    else
      flash[:danger] = "This book is already borrowed!"
      redirect_to '/borrows' 
    end
  end

  def add_borrow
    @borrow = Borrow.new
    book = Book.find(params[:borrow][:book_id])
    student = current_user.student
    @borrow.book = book
    @borrow.student = student
    @borrow.status = false
    @borrow.start_date = DateTime.now
    #@borrow.student_id = 2
    if Borrow.where(:book_id => params[:borrow][:book_id]).blank?
      if @borrow.save
        flash[:success] = "Gratulacje. Wypożyczyleś wskazaną książkę."
        redirect_to '/libraries'
      else
        flash[:danger] = params[:borrow][:book_id]
        redirect_to '/borrows'
      end
    else
      flash[:danger] = "Książka jest już wypożyczona!"
      redirect_to '/borrows' 
    end
  end

  def confirm_borrow
    @borrow = Borrow.new
    @library = Library.find(params[:library_id])
    @book = @library.book.find(params[:book_id])

    
  end

  #def checkStatus(book_id)
    #if Borrow.exists?(book_id: book_id)
end
