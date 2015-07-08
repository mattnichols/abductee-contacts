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

		it "should give email if no name present" do
			contact = create_contact(user, email: "bob@bob.com")
			expect(contact.title).to eq("bob@bob.com")
		end

	end

	describe "has_address" do
		it "should be false if no address information" do
			contact = Contact.new()
			expect(contact.has_address?).to eq(false)
		end

		[:address1, :address2, :city, :state, :postal_code].each do |field|
			it "should be true if #{field} is present" do
				contact = Contact.new()
				contact[field] = "value"
				expect(contact.has_address?).to eq(true)
			end
		end
	end
end