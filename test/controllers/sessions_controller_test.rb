require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest

  def log_in_as(user, password: 'password')
    post '/login', params: { session: { username: user.username, password: password } }
  end

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

  	user = users(:student)
    log_in_as(user)
    get root_path
    assert_equal user.id, session[:user_id]
    assert_equal "student", User.find(session[:user_id]).get_role

  end
  
end
