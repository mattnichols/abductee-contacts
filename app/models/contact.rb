require 'email_validator'

class Contact
  include Mongoid::Document
  
  field :email, type: String
  embedded_in :user

  validates :email,
            :presence => true,
            :email => true
end