class AdminsController < ApplicationController
	before_action :authorize, :authorize_admin

  def index
  end

  def view_all_users
  	@users = User.all
  	render 'admins/users'
  end

private

	def authorize_admin
    if !is_admin
      flash[:danger] = "Permission denied."
      redirect_to root_path
    end
  end
  
end
