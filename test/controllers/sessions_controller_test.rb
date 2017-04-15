require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  # test "should get new" do
  #   get sessions_new_url
  #   assert_response :success
  # end

  # test "administrator authentication" do
  # 	user = users(:admin)
  # 	post '/login', params: {user_id: user.id }
  # 	redirected_to '/administrators'
  # end

  # test "librarian authentication" do
  # 	user = users(:librarian)
  # 	post '/login', params: {user_id: user.id }
  # 	redirected_to '/librarians'
  # end

  test "student authentication" do
  	# user = users(:student)
   #  session[:user_id] = user.id
   #  get :new
   #  assert session.nil?
    # assert_redirected_to '/student'
  	# post '/login', params: {user_id: user.id }
  	# assert_redirected_to '/students'

  end
  
end
