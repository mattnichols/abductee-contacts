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
			post :create, { contact: { email: "lab.rat@abductee.com" } }
			expect(response).to redirect_to(contacts_path)
			expect(assigns(:contact)).to be_valid
		end
	end
end