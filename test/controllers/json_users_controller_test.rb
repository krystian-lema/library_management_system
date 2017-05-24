require 'test_helper'

class JsonUsersControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "add new users (two librarians) from json" do
  	contents = File.read(Rails.root.join('test', 'fixtures', 'files', 'two_librarians.json'))
		# post book_path, headers: auth_headers, env: { RAW_POST_DATA: contents }, as: :json

  	assert_difference('User.count', 2) do
  		post '/users', env: { RAW_POST_DATA: contents }, as: :json
  	end

  end

  test "add new users (librarian and admin) from json" do
  	contents = File.read(Rails.root.join('test', 'fixtures', 'files', 'librarian_and_admin.json'))
		# post book_path, headers: auth_headers, env: { RAW_POST_DATA: contents }, as: :json

  	assert_difference('User.count', 2) do
  		post '/users', env: { RAW_POST_DATA: contents }, as: :json
  	end
  end

  test "add students" do
  	contents = File.read(Rails.root.join('test', 'fixtures', 'files', 'two_students.json'))
		
  	assert_difference('User.count', 2) do
  		post '/users', env: { RAW_POST_DATA: contents }, as: :json
  	end

  	student = User.last.student
  	assert student
  	assert student.id_card
  end

  test "bad user json should not add student-user" do
  	contents = File.read(Rails.root.join('test', 'fixtures', 'files', 'bad_students.json'))
		
  	assert_no_difference('User.count') do
  		post '/users', env: { RAW_POST_DATA: contents }, as: :json
  	end
  end

  test "add three different students" do
  	contents = File.read(Rails.root.join('test', 'fixtures', 'files', 'users.json'))
		
  	assert_difference('User.count', 3) do
  		post '/users', env: { RAW_POST_DATA: contents }, as: :json
  	end

  	student = User.last.student
  	assert student
  	assert student.id_card
  end

end
