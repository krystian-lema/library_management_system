class SessionsController < ApplicationController
  include SessionsHelper
  
  def new
  end

  def create
  	# user = User.find_by_email(params[:email])
    user = User.find_by(username: params[:username])
  	# If the user exists AND the password entered is correct.
  	if user && user.authenticate(params[:password])
    	# Save the user id inside the browser cookie. This is how we keep the user 
    	# logged in when they navigate around our website.
			session[:user_id] = user.id
      flash[:success] = "Login complete."
      redirect_to root_path
    else
    # If user's login doesn't work, send them back to the login form.
      flash[:error] = "Wrong login or password."
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end

end
