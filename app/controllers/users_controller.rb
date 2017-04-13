class UsersController < ApplicationController
  # before_filter :authorize, except: :index
  before_action :find_user, only: [:show, :edit, :update, :destroy, :change_password_view, :change_password]

  def index
    redirect_to '/login' unless current_user
  end

  def new
    @user = User.new
  end

  def create
  	@user = User.new(user_create_params)
  	if @user.save
      session[:user_id] = @user.id
      flash[:success] = "User created."
      redirect_to '/'
  	else
      render 'new'
  	end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_update_params)
      flash[:success] = "Edit success."
      redirect_to root_path
    else
      flash[:error] = "Edit failed."
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "User deleted."
    logout
  end

  def change_password_view
    render 'users/change_password'
  end

  def change_password
    @user.validate_password = true
    if @user.update(user_change_password_params)
      flash[:success] = "Change password success."
      redirect_to root_path
    else
      flash[:error] = "Change password failed."
      render 'users/change_password'
    end
  end

private

  def find_user
    @user = User.find(params[:id])
  end

  def user_create_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

  def user_update_params
    params.require(:user).permit(:username, :email, :first_name, :last_name, :address, :birth_date)
  end

  def user_change_password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

end
