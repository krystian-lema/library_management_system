require 'test_helper'

class UserTest < ActiveSupport::TestCase

	test "valid with all attributes" do
		u = users(:one)
		assert u.valid?
	end

end
