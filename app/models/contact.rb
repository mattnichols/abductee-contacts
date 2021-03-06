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
  # validates_associated :phone_numbers
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
            :allow_blank => true,
            :email => true
  validate :title_present

  search_in :first_name, :last_name, :email
  
  before_save :set_title
  before_save :cleanup_phone_numbers

  def has_address?
    [address1, address2, city, state, postal_code].any? { |address_value| not address_value.blank? }
  end

  def title_present
    if ([first_name, last_name, email].all? { |field| field.blank? })
      errors.add(:base, "Must provide email or name")
      errors.add(:first_name, "provide one")
      errors.add(:last_name, "provide one")
      errors.add(:email, "provide one")
    end
  end
private

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

  def cleanup_phone_numbers
    phone_numbers.each do |phone|
      phone.destroy if phone.phone.blank?
    end
  end
  
end