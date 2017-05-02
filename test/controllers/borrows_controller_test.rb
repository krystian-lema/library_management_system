require 'test_helper'

class BorrowsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get borrows_new_url
    assert_response :success
  end

  test "should get create" do
    get borrows_create_url
    assert_response :success
  end

end
