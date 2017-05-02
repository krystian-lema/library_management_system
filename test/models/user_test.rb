require 'test_helper'

class UserTest < ActiveSupport::TestCase

	test "valid with all attributes" do
		u = users(:student)
		assert u.valid?
	end

	test "is student" do
		u = users(:student)
		assert_equal(u.get_role, "student")
	end

	test "is librarian" do
		u = users(:librarian)
		assert_equal(u.get_role, "librarian")
	end

	test "is admin" do
		u = users(:admin)
		assert_equal(u.get_role, "administrator")
	end

end
