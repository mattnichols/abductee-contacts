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

	describe "title" do
		let (:user) { create_user }

		it "should give last name if present" do
			contact = create_contact(user, last_name: "Bobson")
			expect(contact.title).to eq("Bobson")
		end

		it "should give first and last name if present" do
			contact = create_contact(user, first_name: "Bob", last_name: "Bobson")
			expect(contact.title).to eq("Bobson, Bob")
		end

		it "should give first name if present" do
			contact = create_contact(user, first_name: "Bob")
			expect(contact.title).to eq("Bob")
		end

	end
end