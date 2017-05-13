class LibrariesController < ApplicationController
  before_action :authorize
  before_action :check_manage_permission, only: [:new, :edit, :update]
	def index
		@libraries = Library.all
	end
  def new
  	@library = Library.new
  end

  def create
  	@library = Library.new(library_create_params)
  	if @library.save
      flash[:success] = "Utworzono bibliotekę."
      redirect_to '/libraries'
  	else
      flash[:danger] = "Błąd podczas tworzenia biblioteki!"
      render 'new'
  	end
  end

  def show
  	@library = Library.find(params[:id])

    @books = @library.book(:conditions => { :status => false })

    @library_books = Book.where(library_id: params[:id], status: true)
  end

  def edit
  	@library = Library.find(params[:id])
  end

  def update
	  @library = Library.find(params[:id])
	 
	  if @library.update(library_create_params)
      flash[:success] = "Zaktualizowano informacje o bibliotece."
	    redirect_to @library
	  else
      flash[:success] = "Błąd podczas aktualizacji informacji o bibliotece."
	    render 'edit'
	  end
	end


  def destroy
  end

  private 

  	def library_create_params
  		params.require(:library).permit(:name, :address, :description)
  	end

    def check_manage_permission
      if !is_admin && !is_librarian
        permission_denied
      end
    end
end
