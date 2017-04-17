class LibrariesController < ApplicationController
	def index
		@libraries = Library.all
	end
  def new
  	@library = Library.new
  end

  def create
  	@library = Library.new(library_create_params)
  	if @library.save
      redirect_to '/libraries'
  	else
      render 'new'
  	end
  end

  def show
  	@library = Library.find(params[:id])
  end

  def edit
  	@library = Library.find(params[:id])
  end

  def update
	  @library = Library.find(params[:id])
	 
	  if @library.update(library_create_params)
	    redirect_to @library
	  else
	    render 'edit'
	  end
	end

  def destroy
  end

  private 
  	def library_create_params
  		params.require(:library).permit(:name, :address, :description)
  	end
end
