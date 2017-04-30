class StudentsController < ApplicationController
	before_action :authorize, :authorize_student

  def index
  end

  def borrows
  	@borrows = Borrow.all.where(:student => current_user.student)
  end

private

	def authorize_student
    if !is_student
      flash[:danger] = "Permission denied."
      redirect_to root_path
    end
  end

end
