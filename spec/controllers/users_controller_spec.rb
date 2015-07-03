require 'rails_helper'

RSpec.describe UsersController do
	describe "GET new" do
		it "creates new model" do
			get :new
			expect(assigns(:user)).to be_a_new(User)
		end
	end

	describe "POST create" do
		it "creates valid user" do
			post :create, { user: { email: "test@unit.com", password: "SuperSecret", password_confirmation: "SuperSecret" } }
			expect(assigns(:user)).to be_valid
			expect(response).to redirect_to(contacts_path)
			expect(session[:user_id]).not_to be_nil
		end

		it "rejects invalid user" do
			post :create, { user: { email: "test@unit.com", password: "SuperSecret", password_confirmation: "SuperDifferent" } }
			expect(assigns(:user)).not_to be_valid
			expect(response).to render_template("new")
		end
	end
end