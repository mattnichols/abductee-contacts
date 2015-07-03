require 'rails_helper'

RSpec.describe SessionsController do
	describe "Session Management" do
		include AuthenticationHelpers
		let(:user) { create_user }

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

		it "should logout" do
			login(user)
			expect(session[:user_id]).not_to be_nil
			
			delete :destroy
			expect(session[:user_id]).to be_nil
		end
	end
end