require 'rails_helper'

RSpec.describe "User requesting", type: :request do
  describe "signup" do
    it "should sign user up and redirect to contacts page" do
      get new_user_path
      expect(response).to have_http_status(200)
      expect(response).to render_template(:new)

      post "/users", user: { email: "test@unit.com", password: "Secret", password_confirmation: "Secret" }
      expect(response).to redirect_to(contacts_path)
      follow_redirect!
      expect(response).to render_template(:index)
      expect(response.body).to include("Welcome!")
      expect(response.body).to include("test@unit.com")
    end
  end
  describe "logout" do
    it "should sign user out and redirect to login" do
      post "/users", user: { email: "test@unit.com", password: "Secret", password_confirmation: "Secret" }
      expect(session[:user_id]).not_to be_nil

      get "/logout"
      expect(response).to redirect_to(login_path)
      # follow_redirect!
      expect(session[:user_id]).to be_nil
    end
  end
  describe "signin" do
    it "should sign user out and redirect to login" do
      post "/users", user: { email: "test@unit.com", password: "Secret", password_confirmation: "Secret" }
      get "/logout"
      expect(session[:user_id]).to be_nil

      post "/sessions", { email: "test@unit.com", password: "Secret" }
      expect(session[:user_id]).not_to be_nil
    end
  end
end