class UserMailer < ApplicationMailer
	default from: 'librarymailerpwr@gmail.com'

	def reset_password_email(username, email_address, new_password)
		@username = username
		@password = new_password
		mail(to: email_address, subject: 'Reset hasła')
	end
end
