require 'test_helper'
require 'users_controller'

class UsersControllerTest < ActionDispatch::IntegrationTest
  

	def setup
		@user = users(:one)
	end

	test "login screen" do
		get '/'
		assert_redirected_to '/login'
	end

	test "edit form" do
		get '/users/' + @user.id.to_s + '/edit'
		assert_response :success
	end

  test "create user" do
  	assert_difference('User.count') do
    	post users_url, params: { user: { username: 'username', email: 'email', password: 'password', password_confirmation: 'password' } }
  	end

  	assert User.last.id
  	assert_redirected_to root_path
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

end
