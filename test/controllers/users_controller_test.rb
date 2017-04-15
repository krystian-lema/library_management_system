require 'test_helper'
require 'users_controller'

class UsersControllerTest < ActionDispatch::IntegrationTest
  
	def setup
		@user = users(:student)
	end

  def login(user)
    post '/login', :params => { :email => user.username, :password => 'password' }
    session[:current_user_id] = user.id
  end

	def assert_logged_in
    assert session[:current_user_id].present?
  end

  def assert_not_logged_in
    assert session[:current_user_id].blank?
  end

	test "index with authorization" do
		login(@user)
		assert_logged_in
		assert User.find(session[:current_user_id]).present?
		get '/'
		assert_redirected_to '/student'
	end

	test "edit form" do
		get '/users/' + @user.id.to_s + '/edit'
		assert_response :success
	end

	test "create student" do
		assert_difference('User.count') do
    	post '/students', params: { user: { email: 'newstudent@email.com', first_name: 'Jacek', last_name: 'Student', 
    		address: 'nowhere', birth_date: '1995-09-21' } }
  	end

  	assert User.last
  	assert_redirected_to root_path
  	assert_equal(User.last.get_role, "student")
	end

	test "create librarian" do
		assert_difference('User.count') do
    	post '/librarians', params: { user: { email: 'newlibrarian@email.com', first_name: 'Jacek', last_name: 'Librarian', 
    		address: 'nowhere', birth_date: '1985-09-11' } }
  	end

  	assert User.last
  	assert_redirected_to root_path
  	assert_equal(User.last.get_role, "librarian")
	end

	test "create admin" do
		assert_difference('User.count') do
    	post '/administrators', params: { user: { email: 'newadmin@email.com', first_name: 'Jacek', last_name: 'Admin', 
    		address: 'nowhere', birth_date: '1985-01-21' } }
  	end

  	assert User.last
  	assert_redirected_to root_path
  	assert_equal(User.last.get_role, "administrator")
	end

	test "unique username" do

		assert_difference('User.count') do
    	post '/students', params: { user: { email: 'newstudent@email.com', first_name: 'Jacek', last_name: 'Student', 
    		address: 'nowhere', birth_date: '1995-09-21' } }
  	end

  	assert_no_difference('User.count', "User with the same username should not be created") do
    	post '/students', params: { user: { email: 'newstudent@email.com', first_name: 'Jacek', last_name: 'Student', 
    		address: 'nowhere', birth_date: '1995-09-21' } }
  	end
	end

	test "simple update" do
		old_username = @user.username
		old_email = @user.email

		patch user_url(@user), params: { user: { username: 'updated', email: 'updated' } }
		assert_redirected_to root_path

		assert_not_equal(old_username, @user.reload.username)
		assert_not_equal(old_email, @user.reload.email)
	end

	test "update user data" do
		old_username = @user.username
		old_email = @user.email
		old_first_name = @user.first_name
		old_last_name = @user.last_name
		old_address = @user.address
		old_birth_date = @user.birth_date

		# user_url(@user) = '/users/' + @user.id.to_s
		patch user_url(@user), params: { user: { username: 'updated', email: 'updated', first_name: 'updated', 
			last_name: 'updated', address: 'updated', birth_date: '1990-01-01' } }
		assert_redirected_to root_path

		assert_not_equal(old_username, @user.reload.username)
		assert_not_equal(old_email, @user.reload.email)
		assert_not_equal(old_first_name, @user.reload.first_name)
		assert_not_equal(old_last_name, @user.reload.last_name)
		assert_not_equal(old_address, @user.reload.address)
		assert_not_equal(old_birth_date, @user.reload.birth_date)
	end

	test "change password" do
		old_password = @user.password_digest

		# patch '/users/' + @user.id.to_s + '/change_password', params: { user: { old_password: old_password, 
		# 	new_password: 'new123pass', new_password_confirmation: 'new123pass2' } }
		patch '/users/' + @user.id.to_s + '/change_password', params: { user: { password: 'new123pass', password_confirmation: 'new123pass' } }

		assert_redirected_to root_path
		assert_not_equal(old_password, @user.reload.password_digest)
	end

	test "delete user" do
		assert_difference('User.count', -1, "User should be deleted") do
			delete user_url(@user)
		end
	end

end
