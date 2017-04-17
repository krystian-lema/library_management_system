require 'test_helper'
require 'libraries_controller'


class LibrariesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @library = libraries(:one)
  end

  test "should get new" do
    get libraries_new_url
    assert_response :success
  end

  test "should get create" do
    get libraries_create_url
    assert_response :success
  end

  test "should get edit" do
    get libraries_edit_url
    assert_response :success
  end

  test "should get destroy" do
    get libraries_destroy_url
    assert_response :success
  end

  test "create library" do
    assert_difference('Library.count') do
      post libraries_url, params: { library: { name: 'name', address: 'address', description: 'description' } }
    end

    assert Library.last.id
    assert_redirected_to root_path
  end

end
