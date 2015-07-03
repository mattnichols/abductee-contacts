class User
	include Mongoid::Document
	include ActiveModel::SecurePassword

	field :email, type: String
	field :password_digest, type: String
	field :_id, type: String, default: ->{ email }

	has_secure_password
	validates_uniqueness_of :email
end