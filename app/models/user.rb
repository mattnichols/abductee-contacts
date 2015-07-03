require 'email_validator'

class User
  include Mongoid::Document
  include ActiveModel::SecurePassword

  field :email, type: String
  field :password_digest, type: String
  field :_id, type: String, default: ->{ email }
  embeds_many :contacts

  has_secure_password

  validates :email,
            :uniqueness => { :case_sensitive => false },
            :presence => true,
            :email => true

end