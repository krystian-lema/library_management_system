class AdminsController < ApplicationController
	before_action :authorize, :authorize_admin

  def index
  end

private

	def authorize_admin
    if !is_admin
      flash[:error] = "Permission denied."
      redirect_to root_path
    end
  end
  
end
