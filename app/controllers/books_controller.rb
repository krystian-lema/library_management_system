class BooksController < ApplicationController
  before_action :authorize
  before_action :check_manage_permission, only: [:new, :edit, :update, :delete_book]
	def index
		@books = Book.where(:status => true).paginate(:page => params[:page], :per_page => 50)
    if params[:search]
    @books = Book.search(params[:search]).order("created_at DESC").paginate(:page => params[:page], :per_page => 50)
  else
    @books = Book.where(:status => true).all.order('created_at DESC').paginate(:page => params[:page], :per_page => 50)
  end
	end

	def new
		@book = Book.new
	end
  def create
  	@book = Book.new(book_create_params)
    @book.status = true
  	if @book.save
      flash[:success] = "Dodano książkę."
      redirect_to '/libraries/' + @book.library_id.to_s
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

  def delete_book
    @book = Book.find(params[:book_id])
    if @book.update(:status => false)
      flash[:success] = "Książka zostala usunięta."
      redirect_to(:back)
    else
      flash[:danger] = "Nie udalo się usunąć książki. Skontaktuj się z administratorem."
      redirect_to(:back)
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
