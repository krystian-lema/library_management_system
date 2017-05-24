require 'test_helper'
require 'users_controller'

class UsersControllerTest < ActionDispatch::IntegrationTest
  
	def setup
		@student = users(:student)
		@librarian = users(:librarian)
		@admin = users(:admin)
	end

  test "try to login" do
  	post '/login', :params => { :username => @student.username, :password => "password" }
  	login_as_student
  	assert_redirected_to '/'
  	get '/'
  	assert_redirected_to '/student'
  end

  test "try to login with bad password" do
  	post '/login', :params => { :username => @student.username, :password => "badpassword" }
  	assert_redirected_to '/login'
  end

	test "edit form" do
		login_as_student
		get '/users/' + @student.id.to_s + '/edit'
		assert_response :success
	end

	test "can't create student if no librarian or admin" do
		login_as_student
		assert_no_difference('User.count') do
    	post '/students', params: { user: { email: 'newstudent@email.com', first_name: 'Jacek', last_name: 'Student', 
    		address: 'nowhere', birth_date: '1995-09-21' }, id_card_number: 218453 }
  	end
	end

	test "create librarian" do
		login_as_admin
		assert_difference('User.count') do
    	post '/librarians', params: { user: { email: 'newlibrarian@email.com', first_name: 'Jacek', last_name: 'Librarian', 
    		address: 'nowhere', birth_date: '1985-09-11' } }
  	end
  	assert User.last
  	assert_equal(User.last.get_role, "librarian")
	end

	test "can't create librarian if no admin" do
		login_as_student
		assert_no_difference('User.count') do
    	post '/librarians', params: { user: { email: 'newlibrarian@email.com', first_name: 'Jacek', last_name: 'Librarian', 
    		address: 'nowhere', birth_date: '1985-09-11' } }
  	end

  	login_as_librarian
		assert_no_difference('User.count') do
    	post '/librarians', params: { user: { email: 'newlibrarian@email.com', first_name: 'Jacek', last_name: 'Librarian', 
    		address: 'nowhere', birth_date: '1985-09-11' } }
  	end
	end

	test "create admin" do
		login_as_admin
		assert_difference('User.count') do
    	post '/administrators', params: { user: { email: 'newadmin@email.com', first_name: 'Jacek', last_name: 'Admin', 
    		address: 'nowhere', birth_date: '1985-01-21' } }
  	end
  	assert User.last
  	assert_equal(User.last.get_role, "administrator")
	end

	test "can't create admin if no admin" do
		login_as_student
		assert_no_difference('User.count') do
    	post '/administrators', params: { user: { email: 'newadmin@email.com', first_name: 'Jacek', last_name: 'Admin', 
    		address: 'nowhere', birth_date: '1985-01-21' } }
  	end

  	login_as_librarian
		assert_no_difference('User.count') do
    	post '/administrators', params: { user: { email: 'newadmin@email.com', first_name: 'Jacek', last_name: 'Admin', 
    		address: 'nowhere', birth_date: '1985-01-21' } }
  	end
	end

	test "unique username" do
		login_as_admin
		assert_difference('User.count') do
    	post '/students', params: { user: { email: 'newstudent@email.com', first_name: 'Jacek', last_name: 'Student', 
    		address: 'nowhere', birth_date: '1995-09-21' }, id_card_number: 218453 }
  	end

  	assert_no_difference('User.count', "User with the same username should not be created") do
    	post '/students', params: { user: { email: 'newstudent@email.com', first_name: 'Jacek', last_name: 'Student', 
    		address: 'nowhere', birth_date: '1995-09-21' }, id_card_number: 218453 }
  	end
	end

	test "simple update" do
		login_as_student
		old_username = @student.username
		old_email = @student.email

		patch user_url(@student), params: { user: { username: 'updated', email: 'updated' } }
		assert_redirected_to root_path

		assert_not_equal(old_username, @student.reload.username)
		assert_not_equal(old_email, @student.reload.email)
	end

	test "update user data" do
		login_as_student
		old_username = @student.username
		old_email = @student.email
		old_first_name = @student.first_name
		old_last_name = @student.last_name
		old_address = @student.address
		old_birth_date = @student.birth_date

		# user_url(@user) = '/users/' + @user.id.to_s
		patch user_url(@student), params: { user: { username: 'updated', email: 'updated', first_name: 'updated', 
			last_name: 'updated', address: 'updated', birth_date: '1990-01-01' } }
		assert_redirected_to root_path

		assert_not_equal(old_username, @student.reload.username)
		assert_not_equal(old_email, @student.reload.email)
		assert_not_equal(old_first_name, @student.reload.first_name)
		assert_not_equal(old_last_name, @student.reload.last_name)
		assert_not_equal(old_address, @student.reload.address)
		assert_not_equal(old_birth_date, @student.reload.birth_date)
	end

	test "can't update user data if not authorized" do
		patch user_url(@student), params: { user: { username: 'updated', email: 'updated', first_name: 'updated', 
			last_name: 'updated', address: 'updated', birth_date: '1990-01-01' } }
		assert_redirected_to '/login'
	end

	test "change password" do
		login_as_student
		old_password = @student.password_digest
		patch '/users/' + @student.id.to_s + '/change_password', params: { user: { password: 'new123pass', password_confirmation: 'new123pass' } }

		assert_redirected_to root_path
		assert_not_equal(old_password, @student.reload.password_digest)
	end

	test "can't change password if not authorized" do
		patch '/users/' + @student.id.to_s + '/change_password', params: { user: { password: 'new123pass', password_confirmation: 'new123pass' } }
		assert_redirected_to '/login'
	end

	test "delete user" do
		login_as_student
		assert_difference('User.count', -1, "User should be deleted") do
			delete user_url(@student)
		end

		assert_equal "Użytkownik został usunięty.", flash[:success]
	end

	test "can't delete user if not authorized" do
		assert_no_difference('User.count', "User should not be deleted") do
			delete user_url(@student)
		end
	end

	test "delete user deletes student" do
		student = @student.student
		assert_no_difference('User.count', "User should not be deleted") do
			delete user_url(@student)
		end
		assert_not student
	end

	test "reset password to new one" do
		post '/reset_password', params: { username: @student.username }
		assert_redirected_to root_path
		assert_equal "Nowe hasło zostało wysłane na: " +  @student.email, flash[:success]
	end

	test "should not change password for bad uername" do
		post '/reset_password', params: { username: 'badusername' }
		assert_equal "Nie ma użytkownika z podanym loginem.", flash[:danger]
	end

end
