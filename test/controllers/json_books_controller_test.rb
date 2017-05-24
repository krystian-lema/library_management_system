require 'test_helper'

class JsonBooksControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "add library with books" do
  	contents = File.read(Rails.root.join('test', 'fixtures', 'files', 'library_with_books.json'))
		# post book_path, headers: auth_headers, env: { RAW_POST_DATA: contents }, as: :json

  	assert_difference('Library.count', 1) do
  		post '/library_with_books', env: { RAW_POST_DATA: contents }, as: :json
  	end

  	assert_difference('Book.count', 2) do
  		post '/library_with_books', env: { RAW_POST_DATA: contents }, as: :json
  	end
  end
end
