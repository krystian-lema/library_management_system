class LibrariansController < ApplicationController
	before_action :authorize, :authorize_librarian

  def index
  end

  def borrows
    # trzeba dorobic status w wypozyczeniach i po wypozyczeniu przez studenta ustawic status oczekujace
    # nastepnie filtrowac tutaj wszystkie wypozyczenia ktore czekaja na akceptacje
    # @borrows = Borrow.all.where(:status => "started")

    # temp
    @borrows = Borrow.all
  end

  def student_borrows
    @user = User.find(Student.find(params[:id]).user.id)
    @borrows = Borrow.all.where(:student => Student.find(params[:id]))
  end

  def view_all_students
  	@users = User.all.where(:role => "student")
  	render 'librarians/users'
  end

private

	def authorize_librarian
    if !is_librarian
      flash[:danger] = "Permission denied."
      redirect_to root_path
    end
  end
  
end
