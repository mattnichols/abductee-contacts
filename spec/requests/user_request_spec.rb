require 'rails_helper'

RSpec.describe "New Signup", type: :request do
  describe "Start signup" do
    it "should give the signup page" do
      get new_user_path
      expect(response).to have_http_status(200)

    end
  end
end