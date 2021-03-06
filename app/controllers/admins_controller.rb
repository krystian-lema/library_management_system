class AdminsController < ApplicationController
	before_action :authorize, :authorize_admin

  def index
  end

  def view_all_users
  	#@users = User.all
    if params[:search]
      @users = User.search(params[:search]).order("created_at DESC").paginate(:page => params[:page], :per_page => 50)
    else
      @users = User.paginate(:page => params[:page], :per_page => 20)
    end
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
