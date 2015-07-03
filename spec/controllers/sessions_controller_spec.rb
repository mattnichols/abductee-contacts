require 'rails_helper'

RSpec.describe SessionsController do
	describe "Session Management" do
		let(:user) { User.create(email: "unit@testing.com", password: "$3cr3t", password_confirmation: "$3cr3t") }

		it "should show login page" do
			get :new
			expect(response).to render_template("new")
		end

		it "should login" do
			post :create, { email: user.email, password: "$3cr3t" }
			expect(session[:user_id]).to eq(user.id)
			expect(response).to redirect_to(contacts_path)
		end

		it "should fail incorrect login" do
			post :create, { email: user.email, password: "WRONG" }
			expect(session[:user_id]).to be_nil
			expect(response).to render_template("new")
		end

	end
end