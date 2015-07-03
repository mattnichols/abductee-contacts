require 'rails_helper'

RSpec.describe "New Signup", type: :request do
  describe "Start signup" do
    it "should give the signup page" do
      get new_user_path
      expect(response).to have_http_status(200)
      expect(response).to render_template(:new)

      post "/users", user: { email: "test@unit.com", password: "Secret", password_confirmation: "Secret" }
      expect(response).to redirect_to(contacts_path)
    end
  end
end