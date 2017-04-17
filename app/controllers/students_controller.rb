class StudentsController < ApplicationController
	before_action :authorize, :authorize_student

  def index
  end

private

	def authorize_student
    if !is_student
      flash[:error] = "Permission denied."
      redirect_to root_path
    end
  end

end
