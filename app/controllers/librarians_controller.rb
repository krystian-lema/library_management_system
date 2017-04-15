class LibrariansController < ApplicationController
	before_action :authorize, :authorize_librarian

  def index
  end

private

	def authorize_librarian
    if !is_librarian
      flash[:error] = "Permission denied."
      redirect_to root_path
    end
  end
  
end
