ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def login_as_student
  	user = users(:student)
  	post '/login', :params => { :username => user.username, :password => "password" }
  end

  def login_as_librarian
    user = users(:librarian)
  	post '/login', :params => { :username => user.username, :password => "password" }
  end

  def login_as_admin
    user = users(:admin)
  	post '/login', :params => { :username => user.username, :password => "password" }
  end

end
