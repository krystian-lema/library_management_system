class LibrariansController < ApplicationController
	before_action :authorize, :authorize_librarian

  def index
  end

  def view_all_students
  	@users = User.all.where(:role => "student")
  	render 'librarians/users'
  end

private

	def authorize_librarian
    if !is_librarian
      flash[:error] = "Permission denied."
      redirect_to root_path
    end
  end
  
end
