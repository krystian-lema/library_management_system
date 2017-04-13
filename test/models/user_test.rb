require 'test_helper'

class UserTest < ActiveSupport::TestCase

	test "valid with all attributes" do
		u = User.new
		u.username = 'NewUser'
		u.email = 'newuser@email.com'
		u.password = 'password'
		u.password_confirmation = 'password'
		assert u.valid?, "User was not valid"
	end



end
