class LibrariansController < ApplicationController
	before_action :authorize, :authorize_librarian

  def index
  end

  def borrows
    @borrows = Borrow.all.where(:status => 0)
  end

  def confirm_borrow
    @borrow = Borrow.find(params[:borrow][:borrow_id])
    time_now = DateTime.now
    if @borrow.update(:status => 1, :start_date => time_now)
      redirect_to(:back)
    else
      redirect_to root_path
    end
  end

  def finish_borrow
    @borrow = Borrow.find(params[:borrow][:borrow_id])
    @borrow_archive = BorrowArchive.new
    @borrow_archive.book_id = @borrow.book_id
    @borrow_archive.student_id = @borrow.student_id
    @borrow_archive.start_date = @borrow.start_date
    @borrow_archive.end_date = DateTime.now

    if @borrow_archive.save
      @borrow.destroy
      flash[:success] = "Zwrócono książkę!"
      redirect_to(:back)
    else
      flash[:danger] = "Nie udalo się zwrócić książki. Skontaktuj się z administratorem!"
      redirect_to(:back)
    end

  end

  def student_borrows
    @user = User.find(Student.find(params[:id]).user.id)
    @borrows = Borrow.all.where(:student => Student.find(params[:id]))
    @borrows_archive = BorrowArchive.all.where(:student => Student.find(params[:id]))
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
