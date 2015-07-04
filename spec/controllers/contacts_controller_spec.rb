require 'rails_helper'

RSpec.describe ContactsController do
	include AuthenticationHelpers

	let(:user) { create_user }
	before { login(user) }

	describe "GET index" do
		it "should render index view" do
			get :index
			expect(response).to have_http_status(:success)
			expect(response).to render_template(:index)
		end

		it "should load current user's contacts" do
			user.contacts.create(email: "probed@abductee.com")
			user.contacts.create(email: "not.again@abductee.com")

			get :index
			expect(response).to have_http_status(:success)
			expect(assigns(:contacts).length).to eq(2)
		end

		describe "searching user's contacts" do
			before do
				@user = login_new_user(email: "searchy@searcherson.com")
				@contact1 = create_contact(@user, email: "em1@domain1.com", first_name: "fred", last_name: "searchable")
				@contact2 = create_contact(@user, email: "em2@domain2.com", first_name: "fred", last_name: "found")
				@contact3 = create_contact(@user, email: "em3@domain3.com", first_name: "betty", last_name: "bygone")

				@another_user = create_user(email: "searchy2@searcherson.com")
				@another_contact = create_contact(@another_user, email: "found@domain3.com", first_name: "fred", last_name: "bygone")
			end

			it "should find contacts by first name" do
				get :index, q: "fred"
				expect(assigns(:contacts).size).to eq(2)
				expect(assigns(:contacts)).to include(@contact1, @contact2)
			end
			it "should find contacts by last name" do
				get :index, q: "found"
				expect(assigns(:contacts).size).to eq(1)
				expect(assigns(:contacts)).to include(@contact2)
			end
			it "should find contacts by email" do
				get :index, q: "domain3"
				expect(assigns(:contacts).size).to eq(1)
				expect(assigns(:contacts)).to include(@contact3)
			end
		end
	end

	describe "GET new" do
		it "should load new view" do
			get :new
			expect(response).to have_http_status(:success)
			expect(assigns(:contact)).to be_a_new(Contact)
			expect(response).to render_template(:new)
		end
	end

	describe "POST create" do
		it "should load new view" do
			post :create, { contact: { email: "lab.rat@abductee.com", first_name: "Unit", last_name: "Test", address1: "123 Test Ave", address2: "Suite 100", city: "Testerville", state: "OH", postal_code: "90210" } }
			expect(response).to redirect_to(contacts_path)
			expect(assigns(:contact)).to be_valid
		end
	end

	describe "GET edit" do
		let(:contact) { create_contact(user) }

		it "should show edit form" do
			get :edit, id: contact
			expect(assigns(:contact)).to eq(contact)
		end
	end

	describe "PUT update" do
		let(:contact) { create_contact(user) }

		it "should update contact information" do
			put :update, id: contact, contact: { address1: "123 New Address" }
			expect(response).to redirect_to(contacts_path)
		end
	end

	describe "DELETE destroy" do
		let(:contact) { create_contact(user) }

		it "should delete contact" do
			create_contact(user)
			create_contact(user)

			delete :destroy, id: contact
			expect(response).to redirect_to(contacts_path)
			expect{ contact.reload }.to raise_error(Mongoid::Errors::DocumentNotFound)
		end
	end

end