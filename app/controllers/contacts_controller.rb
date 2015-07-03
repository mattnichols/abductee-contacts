class ContactsController < ApplicationController
	before_filter :authorize
	
	def index
		@contacts = current_user.contacts
	end
end