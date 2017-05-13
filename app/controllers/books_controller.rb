class BooksController < ApplicationController
  before_action :authorize
  before_action :check_manage_permission, only: [:new, :edit, :update, :delete_book]
	def index
		@books = Book.all
	end

	def new
		@book = Book.new
	end
  def create
  	@book = Book.new(book_create_params)
    @book.status = true
  	if @book.save
      flash[:success] = "Dodano książkę."
      redirect_to '/books'
  	else
      flash[:danger] = "Błąd podczas dodawania książki. "
      render 'new'
  	end
  end

  def edit
  	@library = Library.find(params[:library_id])
  	@book = @library.book.find(params[:id])
  end

  def update
  	 @book = Book.find(params[:id])
	  if @book.update(book_create_params)
	    flash[:success] = "Zaktualizowano informacje o książce."
	    redirect_to library_book_path(@book.library_id, @book.id)
	  else
      flash[:danger] = "Błąd podczas aktualizacji informacji o książce. "
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

    def check_manage_permission
      if !is_admin && !is_librarian
        permission_denied
      end
    end
end
