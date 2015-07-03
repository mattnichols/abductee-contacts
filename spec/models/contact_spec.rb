require 'rails_helper'

RSpec.describe Contact do
	include AuthenticationHelpers

	describe "validations" do
		let (:user) { create_user }

		it "should require email address" do
			expect(create_contact(user, email: nil).errors).to include(:email)
		end

		it "should validate email address" do
			expect(create_contact(user, email: "invalid@email").errors).to include(:email)
			expect(create_contact(user, email: "valid@email.com").errors).not_to include(:email)
		end
	end
end