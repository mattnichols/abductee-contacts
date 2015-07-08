class PhoneNumber
  include Mongoid::Document
	field :phone,       type: String
	field :phone_type,  type: String

	embedded_in :contact
end