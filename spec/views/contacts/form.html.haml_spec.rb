require 'rails_helper'

RSpec.describe "contacts/_form", type: :view do
	include AuthenticationHelpers

	describe "with invalid contact" do
		before do
			view.extend FormHelpers
			@user = login_new_user
			@contact = create_contact(@user, email: nil)
		end

		it "should render field errors" do
			render
			assert_select "article#field_email div.field_with_errors label.control-label"
		end
	end
end