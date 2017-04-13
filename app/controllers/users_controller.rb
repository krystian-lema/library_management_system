class UsersController < ApplicationController
  # before_filter :authorize, except: :index
  before_action :find_user, only: [:show, :edit, :update, :destroy]

  def index
    redirect_to '/login' unless current_user
  end

  def new
    @user = User.new
  end

  def create
  	user = User.new(user_params)
  	if user.save
      session[:user_id] = user.id
      flash[:success] = "User created."
      redirect_to '/'
  	else
      flash[:error] = user.errors.full_messages
      redirect_to '/signup'
  	end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
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

private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

end
