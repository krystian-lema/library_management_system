require 'test_helper'

class StudentsControllerTest < ActionDispatch::IntegrationTest
  
  def setup
  	@user = users(:student)
  	login_as_student
  end

  test "create student creates id card" do
  	login_as_admin
		assert_difference('User.count') do
    	post '/students', params: { user: { email: 'newstudent@email.com', first_name: 'Jacek', last_name: 'Student', 
    		address: 'nowhere', birth_date: '1995-09-21' }, id_card_number: 218453 }
  	end
  	created_student = User.last.student
    assert created_student
  	assert created_student.id_card
  	assert_equal(created_student, Student.find(created_student.id_card.student_id))
  end

  test "delete student user deletes student" do
    login_as_admin
    assert_difference('User.count') do
      post '/students', params: { user: { email: 'newstudent@email.com', first_name: 'Jacek', last_name: 'Student', 
        address: 'nowhere', birth_date: '1995-09-21' }, id_card_number: 218453 }
    end
    user = User.find_by(email: 'newstudent@email.com')
    student_id = user.student.id

    assert_difference('User.count', -1, "User should be deleted") do
      delete user_url(user)
    end
    assert Student.where(:id => student_id).blank?
  end

  test "delete student user deletes id card" do
    login_as_admin
    assert_difference('User.count') do
      post '/students', params: { user: { email: 'newstudent@email.com', first_name: 'Jacek', last_name: 'Student', 
        address: 'nowhere', birth_date: '1995-09-21' }, id_card_number: 218453 }
    end
    user = User.find_by(email: 'newstudent@email.com')
    id_card_id = user.student.id_card.id

    assert_difference('User.count', -1, "User should be deleted") do
      delete user_url(user)
    end
    assert IdCard.where(:id => id_card_id).blank?
  end

end
