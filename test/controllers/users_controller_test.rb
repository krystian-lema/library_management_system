require 'test_helper'
require 'users_controller'

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  test "create user" do
  	assert_difference('User.count') do
    	post users_url, params: { user: { username: 'username', email: 'email', password: 'password', password_confirmation: 'password' } }
  	end

  	assert_redirected_to root_path
	end

end
