require 'email_validator'

class Contact
  include Mongoid::Document
  include Mongoid::Search
  max_paginates_per 10

  field :email,       type: String
	field :first_name,  type: String  
	field :last_name,   type: String
	field :phone,       type: String
	field :address1,    type: String 
	field :address2,    type: String 
	field :city,        type: String 
	field :state,       type: String 
	field :postal_code, type: String 

  belongs_to :user

  validates :email,
            :presence => true,
            :email => true

  search_in :first_name, :last_name, :email

  def title
  	# Try using name
  	t = last_name || ""
  	unless first_name.blank?
  		t += ((t.blank?) ? first_name : ", #{first_name}")
	  end

	  # User email if no name
	  if t.blank?
	  	t = email
	  end

  	t
  end

  def has_address?
    [address1, address2, city, state, postal_code].any? { |address_value| not address_value.blank? }
  end
end