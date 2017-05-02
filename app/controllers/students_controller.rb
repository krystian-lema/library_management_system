class StudentsController < ApplicationController
	before_action :authorize, :authorize_student

  def index
  end

  def borrows
  	@borrows = Borrow.all.where(:student => current_user.student)
  end

  def add_borrow
    @borrow = Borrow.new
    book = Book.find(params[:book][:book_id])
    student = current_user.student
    @borrow.book = book
    @borrow.student = student
    @borrow.status = false
    @borrow.start_date = DateTime.now
    #@borrow.student_id = 2
    if Borrow.where(:book_id => params[:book][:book_id]).blank?
      if @borrow.save
        flash[:success] = "Gratulacje. Wypożyczyleś wskazaną książkę."
        redirect_to student_borrows_path
      else
        flash[:danger] = "Bląd. Nie udalo się wypożyczyć ksiązki. Skontaktuj się z administratorem."
        redirect_to root_path
      end
    else
      flash[:danger] = "Nie można wypożyczyć książki - jest już wypożyczona!"
      redirect_to(:back)
    end
  end

private

	def authorize_student
    if !is_student
      flash[:danger] = "Permission denied."
      redirect_to root_path
    end
  end

end
