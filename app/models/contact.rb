class Contact
	include Mongoid::Document
	field :email, type: String

	embedded_in :user
end