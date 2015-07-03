require 'rails_helper'

RSpec.describe User do
	describe "authentication when using Mongoid" do
		let(:user) { User.new(email: "test@unit.com", password: "$3cr3t", password_confirmation: "$3cr3t") }

		it "should confirm password" do
			user.password_confirmation = "different"
			expect(user).not_to be_valid

			user.password_confirmation = "$3cr3t"
			expect(user).to be_valid
		end

		it "should authenticate" do
			expect(user.authenticate("$3cr3t")).to eq(user)
		end

		it "should not authenticate with wrong password" do
			expect(user.authenticate("WRONG")).to eq(false)
		end
	end

	describe "constraints" do
		include AuthenticationHelpers

		it "should validate email uniqueness" do
			expect(User.create(email: "test@unit.com", password: "$3cr3t", password_confirmation: "$3cr3t")).to be_valid
			expect(User.create(email: "test@unit.com", password: "$3cr3t", password_confirmation: "$3cr3t")).not_to be_valid
		end

		it "should require email address" do
			expect(create_user(email: nil).errors).to include(:email)
		end

		it "should validate email address format" do
			expect(create_user(email: "invalid.email").errors).to include(:email)
			expect(create_user(email: "invalid").errors).to include(:email)
			expect(create_user(email: "inv@lid").errors).to include(:email)
			expect(create_user(email: "inv@lid").errors[:email]).to eq(["is not a valid email"])
			expect(create_user(email: "valid@email.com").errors).not_to include(:email)
		end

	end
end