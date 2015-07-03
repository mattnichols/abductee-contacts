require 'rails_helper'

RSpec.describe UsersController do

	describe "GET new" do
		it "creates new model" do
			get :new
			expect(assigns(:user)).to be_a_new(User)
		end
	end

end