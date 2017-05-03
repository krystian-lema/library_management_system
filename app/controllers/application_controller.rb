class ApplicationController < ActionController::Base

	# Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def permission_denied
      flash[:danger] = "Permission denied."
      redirect_to root_path
    end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def authorize
    redirect_to '/login' unless current_user
  end

  def logout
    redirect_to '/logout'
  end

  def is_admin
    if current_user && current_user.get_role == "administrator"
      return true
    else
      return false
    end
  end
  helper_method :is_admin

  def is_librarian
    if current_user && current_user.get_role == "librarian"
      return true
    else
      return false
    end
  end
  helper_method :is_librarian

  def is_student
    if current_user && current_user.get_role == "student"
      return true
    else
      return false
    end
  end
  helper_method :is_student

  def management_role

  end
  
end
