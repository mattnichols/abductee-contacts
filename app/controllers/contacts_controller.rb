class ContactsController < ApplicationController
	before_filter :authorize
	before_filter :load_contact, only: [:edit, :update, :destroy]
	
	def index
		if params[:q].blank?
			@contacts = current_user.contacts.order(sorting_title: :asc).page(params[:page]).per(10)
		else
			@contacts = current_user.contacts.full_text_search(params[:q]).order(sorting_title: :asc).page(params[:page]).per(10)
		end
		respond_to do |format|
			format.html
			format.js
		end
	end

	def new
		@contact = Contact.new
		@contact.phone_numbers.build
	end

	def create
		@contact = current_user.contacts.create(contact_attributes)
		if @contact.valid?
			respond_to do |format|
				format.html { redirect_to contacts_path, flash: { info: "Contact created" } }
			end
		else
			respond_to do |format|
				format.html { render "new" }
			end
		end
	end

	def edit
		@contact.phone_numbers.build if @contact.phone_numbers.empty?
	end

	def update
		if @contact.update(contact_attributes)
			respond_to do |format|
				format.html { redirect_to contacts_path, flash: { info: "Contact updated" } }
			end
		end
	end

	def destroy
		@contact.destroy
		respond_to do |format|
			format.html { redirect_to contacts_path, flash: { info: "Contact deleted" } }
			format.js
		end
	end

	private

	def contact_attributes
		params.require(:contact).permit(
			:first_name, 
			:last_name, 
			:email, 
			:phone, 
			:address1, 
			:address2, 
			:city, 
			:state, 
			:postal_code,
			phone_numbers_attributes: [ :id, :phone, :phone_type, :_destroy ])
	end

	def load_contact
		@contact = current_user.contacts.find(params[:id])
	end
end