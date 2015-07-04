class ContactsController < ApplicationController
	before_filter :authorize
	before_filter :load_contact, only: [:edit, :update, :destroy]
	
	def index
		if params[:q].blank?
			@contacts = current_user.contacts
		else
			@contacts = current_user.contacts.full_text_search(params[:q])
		end
	end

	def new
		@contact = Contact.new
	end

	def create
		@contact = current_user.contacts.create(contact_attributes)
		if @contact.valid?
			respond_to do |format|
				format.html { redirect_to contacts_path, info: "Contact created" }
			end
		else
			respond_to do |format|
				format.html do
					render "new"
				end
			end
		end
	end

	def edit
	end

	def update
		if @contact.update(contact_attributes)
			respond_to do |format|
				format.html { redirect_to contacts_path, info: "Contact updated" }
			end
		end
	end

	def destroy
		@contact.destroy
		respond_to do |format|
			format.html { redirect_to contacts_path, info: "Contact deleted" }
		end
	end

	private

	def contact_attributes
		params.require(:contact).permit(:first_name, :last_name, :email, :phone, :address1, :address2, :city, :state, :postal_code)
	end

	def load_contact
		@contact = current_user.contacts.find(params[:id])
	end
end