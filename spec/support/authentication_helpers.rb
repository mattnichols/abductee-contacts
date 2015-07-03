module AuthenticationHelpers
	def create_user(fields = {})
		User.create({ email: "test@unit.com", password: "$3cr3t", password_confirmation: "$3cr3t" }.merge(fields))
	end

	def login(user)
		session[:user_id] = user.id
		user
	end

	def login_new_user(fields = {})
		login(create_user(fields))
	end

	def create_contact(user, fields = {})
		user.contacts.create({ email: "test@unit.com" }.merge(fields))
	end
end