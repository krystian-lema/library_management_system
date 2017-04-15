class UsersController < ApplicationController
  # before_action :authorize, only: :index
  before_action :authorize
  before_action :authorize_admin, only: [:new_admin, :create_admin, :new_librarian, :create_librarian]
  before_action :authorize_admin_or_librarian, only: [:new_student, :create_student]
  before_action :find_user, only: [:show, :edit, :update, :destroy, :change_password_view, :change_password]

  def index
    if is_admin
      redirect_to '/administrator'
    elsif is_librarian
      redirect_to '/librarian'
    else  
      redirect_to '/student'
    end
  end

  def new
    @user = User.new
  end

  def new_user(user_params)
    username = user_params[:first_name] + user_params[:last_name]
    password = user_params[:last_name].downcase
    return User.new(
                      username: username,
                      email: user_params[:email],
                      password: password,
                      first_name: user_params[:first_name],
                      last_name: user_params[:last_name],
                      address: user_params[:address],
                      birth_date: user_params[:birth_date]
                      )
  end

  def new_admin
    @user = User.new
    render 'users/new_admin'
  end

  def create_admin
    new_user = new_user(user_create_params)
    new_user.role = "administrator"
    @user = new_user
    save_new_user('users/new_admin')
  end

  def new_librarian
    @user = User.new
    render 'users/new_librarian'
  end

  def create_librarian
    new_user = new_user(user_create_params)
    new_user.role = "librarian"
    @user = new_user
    save_new_user('users/new_librarian')
  end

  def new_student
    @user = User.new
    render 'users/new_student'
  end

  def create_student
    new_user = new_user(user_create_params)
    new_user.role = "student"
    @user = new_user
    save_new_user('users/new_student')
  end

  def save_new_user(on_failed_view)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "User created."
      redirect_to root_path
    else
      render on_failed_view
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
    params.require(:user).permit(:email, :first_name, :last_name, :address, :birth_date)
  end

  def user_update_params
    params.require(:user).permit(:username, :email, :first_name, :last_name, :address, :birth_date)
  end

  def user_change_password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def authorize_admin
    if !is_admin
      flash[:error] = "Permission denied."
      redirect_to root_path
    end
  end

  def authorize_admin_or_librarian
    if !is_admin && !is_librarian
      flash[:error] = "Permission denied."
      redirect_to root_path
    end
  end

end
