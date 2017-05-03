class BooksController < ApplicationController
	def index
		@books = Book.all
	end

	def new
		@book = Book.new
	end
  def create
  	#@library = Library.find(@book.library_id)
  	#@book = @library.books.find(params[:book_id])

  	@book = Book.new(book_create_params)
    @book.status = true
  	if @book.save
      redirect_to '/books'
  	else
      render 'new'
  	end
  end

  def edit
  	@library = Library.find(params[:library_id])
  	@book = @library.book.find(params[:id])
  	#@book = Book.find(params[:id])
  end

  def update
  	 
  	 #@library = Library.find(params[:library_id])
  	 #@book = Book.find(params[:id])

  	 @book = Book.find(params[:id])

	 
	  if @book.update(book_create_params)
	    #redirect_to library_book_path(params[:id])
	    redirect_to library_book_path(@book.library_id, @book.id)
	  else
	    render 'edit'
	  end
  end
	def show
		@library = Library.find(params[:library_id])
		@book = @library.book.find(params[:id])

		@borrows = @book.borrows

	end

  def delete_book
    @book = Book.find(params[:book_id])
    if @book.update(:status => false)
      flash[:success] = "Książka zostala usunięta."
      redirect_to(:back)
    else
      flash[:danger] = "Nie udalo się usunąć książki. Skontaktuj się z administratorem."
      rediret_to(:back)
    end
  end

	private 
  	def book_create_params
  		params.require(:book).permit(:title, :author, :edition, :publication_date, :ISBN, :signature, :library_id)
  	end
end
