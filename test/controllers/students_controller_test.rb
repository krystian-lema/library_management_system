require 'test_helper'

class StudentsControllerTest < ActionDispatch::IntegrationTest
  
  def setup
  	@user = users(:student)
  	# @controller.session[:user_id] = @user.id
  end

  # test "should get index" do
  #   get students_index_url
  #   assert_response :success
  # end

end
