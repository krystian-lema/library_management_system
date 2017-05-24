class JsonUsersController < ApplicationController
	skip_before_filter :verify_authenticity_token, :only => [:import_users, :import_user]
  http_basic_authenticate_with name:"admin_code", password: "123654789"

	def import_users
		# parse body send in json
		parsed_body = get_parsed_body

		# create array for import informations
		import_info_hashes = Array.new

    @users_added = 0
    # add users
  	parsed_body['users'].each do |user|
  		import_info_hashes << import_user(user)
  	end

  	# render info
  	respond_to do |format|
	    format.json { 
	    	render json: {import_info_hashes: import_info_hashes, users_added: @users_added}
	    }
    end


	end

	def import_user(user_data)
		username = user_data['first_name'] + user_data['last_name']
    password = user_data['last_name'].downcase

    if User.where(:username => username).present?
      signs = (1111..9999).to_a
      username += signs[rand(signs.length)].to_s
    end

    @user = User.new(
                      username: username,
                      email: user_data['email'],
                      password: password,
                      first_name: user_data['first_name'],
                      last_name: user_data['last_name'],
                      address: user_data['address'],
                      birth_date: user_data['birth_date'],
                      role: user_data['role']
                      )

    if user_data['role'] == "student"
    	if user_data['id_card'].nil?
    		return {success: false, error: "There is no id card number data.", user: user_data}      
    	end
    	@user.student = Student.new(is_active: true)
    	unless @user.student.save
    		return {success: false, error: "Student cannot be created.", details: @user.student.errors.full_messages.first, user: user_data}      
    	end
    	@user.student.id_card = IdCard.new(number: user_data['id_card'])
    	unless @user.student.id_card.save
    		return {success: false, error: "Id card cannot be created.", details: @user.student.id_card.errors.full_messages.first, user: user_data}      
    	end
    end

    if @user.save
      @users_added += 1
      return {success: true}
    else
      unless @user.nil?
        unless @user.student.nil?
          unless @user.student.id_card.nil?
            @user.student.id_card.destroy
          end
          @user.student.destroy
        end
        @user.destroy
      end
			return {success: false, error: "User cannot be created.", details: @user.errors.full_messages.first, user: user_data}      
    end
	end


private

	def get_parsed_body
    request.body.rewind
    request_body = request.body.read
    if request_body.empty?
      request_body = '{}'
    end
    parsed_body = JSON.parse(request_body)
    parsed_body
  end	

end
