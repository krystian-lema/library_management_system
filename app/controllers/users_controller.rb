class UsersController < ApplicationController
  # before_action :authorize, only: :index
  before_action :authorize
  before_action :authorize_admin, only: [:new_admin, :create_admin, :new_librarian, :create_librarian]
  before_action :authorize_admin_or_librarian, only: [:new_student, :create_student]
  before_action :find_user, only: [:show, :edit, :update, :destroy, :change_password_view, :change_password, :reset_password]
  before_action :check_edit_permission, only: [:edit, :update]
  before_action :check_destroy_permission, only: :destroy
  before_action :check_change_password_permission, only: [:change_password_view, :change_password]
  before_action :check_reset_password_permission, only: :reset_password

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
    @user.student = Student.new
    @user.student.id_card = IdCard.new
    @user.create_student = true
    render 'users/new_student'
  end

  def create_student
    @user = new_user(student_create_params)
    @user.role = "student"
    @user.student = Student.new(is_active: true)
    @user.student.id_card = IdCard.new(number: student_create_params[:id_card_number])

    if @user.save && @user.student.save && @user.student.id_card.save
      flash[:success] = "User created."
      redirect_to root_path
    else
      unless @user.nil?
        unless @user.student.nil?
          unless @user.student.id_card.nil?
            @user.student.id_card.destroy
          end
          @user.student.destroy
        end
        @user.destroy
      end
      render 'users/new_student'
    end
  end

  def save_new_user(on_failed_view)
    if @user.save
      flash[:success] = "User created."
      redirect_to :back
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
      if (correct_user(@user))
        redirect_to root_path
      else
        redirect_to :back
      end
    else
      flash[:danger] = "Edit failed."
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "User deleted."
    if correct_user(@user)
      logout
    else
      redirect_to :back
    end
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
      flash[:danger] = "Change password failed."
      render 'users/change_password'
    end
  end

  def reset_password
    new_password = @user.first_name + @user.last_name
    change_password(password: new_password, password_confirmation: new_password)
  end

private

  def find_user
    if User.where(:id => params[:id]).blank?
      @user = nil
      redirect_to root_path
    else
      @user = User.find(params[:id])
    end
  end

  def user_create_params
    params.require(:user).permit(:email, :first_name, :last_name, :address, :birth_date)
  end

  def student_create_params
    p = params.require(:user).permit(:email, :first_name, :last_name, :address, :birth_date)
    p.merge!(params.permit(:id_card_number))
  end

  def user_update_params
    params.require(:user).permit(:username, :email, :first_name, :last_name, :address, :birth_date)
  end

  def user_change_password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def permission_denied
    flash[:danger] = "Permission denied."
    redirect_to root_path
  end

  def authorize_admin
    if !is_admin
      permission_denied
    end
  end

  def authorize_admin_or_librarian
    if !is_admin && !is_librarian
      permission_denied
    end
  end

  def correct_user(user)
    if user == current_user
      return true
    else
      return false
    end
  end

  def check_edit_permission
    user_to_edit = User.find(params[:id])
    if !correct_user(user_to_edit)
      if user_to_edit.get_role == "student"
        if !is_admin && !is_librarian
          permission_denied
        end
      else
        if !is_admin
          permission_denied
        end
      end
    end
  
  end

  def check_destroy_permission
    if !correct_user(User.find(params[:id])) && !is_admin
      permission_denied
    end
  end

  def check_change_password_permission
    if !correct_user(User.find(params[:id]))
      permission_denied
    end
  end

  def check_reset_password_permission
    if !is_admin && !is_librarian
      permission_denied
    end
  end

end
