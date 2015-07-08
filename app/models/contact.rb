require 'email_validator'

class Contact
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  include Mongoid::Search
  
  # Person
	field :first_name,  type: String  
	field :last_name,   type: String
  field :email,       type: String
  
  # Phone Numbers
  embeds_many :phone_numbers
  accepts_nested_attributes_for :phone_numbers, allow_destroy: true

  # Address
	field :address1,    type: String 
	field :address2,    type: String 
	field :city,        type: String 
	field :state,       type: String 
	field :postal_code, type: String
  
  # Owner
  belongs_to :user
  
  validates :email,
            :presence => true,
            :email => true
  search_in :first_name, :last_name, :email
  
  # Lazy phone number migration
  after_initialize :migrate_phone_data

  # Lazy migrate title sorting
  after_initialize :set_title
  before_save :set_title
  
  def migrate_phone_data
    unless read_attribute(:phone).blank?
      if phone_numbers.count > 0
        phone_numbers.destroy_all
      end
      phone_numbers.create(phone: read_attribute(:phone), phone_type: "home")
      remove_attribute(:phone)
    end
  end

  def set_title
  	# Try using name
  	t = last_name.blank? ? "" : last_name
  	unless first_name.blank?
  		t += ((t.blank?) ? first_name : ", #{first_name}")
	  end
    
	  # User email if no name
	  if t.blank?
	  	t = email
	  end
    
  	self[:sorting_title] = (self[:title] = t).downcase unless t.nil?
  end
  
  def has_address?
    [address1, address2, city, state, postal_code].any? { |address_value| not address_value.blank? }
  end
end