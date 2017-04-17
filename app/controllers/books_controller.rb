class BooksController < ApplicationController
	def index
		@books = Book.all
	end

	def new
		@book = Book.new
	end
  def create
  	@book = Book.new(book_create_params)
  	if @book.save
      redirect_to '/books'
  	else
      render 'new'
  	end
  end

  def edit
  	@book = Book.find(params[:id])
  end

  def update

  end
	def show

	end

	def destroy

	end

	private 
  	def book_create_params
  		params.require(:book).permit(:title, :author, :edition, :publication_date, :ISBN, :signature, :library_id)
  	end
end
