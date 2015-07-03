require 'rails_helper'

RSpec.describe ContactsController do
	describe "GET index" do
		let(:user) { User.create(email: "test@unit.com", password: "$3cr3t", password_confirmation: "$3cr3t") }

		it "should render index view" do
			session[:user_id] = user.id
			
			get :index
			expect(response).to have_http_status(:success)
		end

		it "should load current user's contacts" do
			user.contacts.create(email: "probed@abductee.com")
			user.contacts.create(email: "probed@abductee.com")

			session[:user_id] = user.id

			get :index
			expect(response).to have_http_status(:success)
			expect(assigns(:contacts).length).to eq(2)
		end

	end
end