class ContactsController < ApplicationController
	before_filter :authorize
	
	def index
		@contacts = current_user.contacts
	end

	def new
		@contact = Contact.new
	end

	def create
		@contact = current_user.contacts.create(params.require(:contact).permit(:email))
		if @contact.valid?
			respond_to do |format|
				format.html { redirect_to contacts_path, info: "Contact created" }
			end
		else
			respond_to do |format|
				format.html do
					flash[:error] = "Unable to create contact"
					render "new"
				end
			end
		end
	end
end