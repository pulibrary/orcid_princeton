# frozen_string_literal: true
require "rails_helper"

RSpec.describe "Errors", type: :request do
  let(:user) { FactoryBot.create :user }

  describe "GET a non-existent page" do
    it "returns a not_found error" do
      login_as user
      get "/a_non_existent_page"
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "GET a user page without being logged in first" do
    it "redirects to login" do
      get "/users/fake_user"
      expect(response).to have_http_status(:redirect)
    end
  end

  describe "a logged in user tries to GET a non existent user" do
    it "returns status forbidden" do
      login_as user
      get "/users/fake_user"
      expect(response).to have_http_status(:forbidden)
    end
  end

  describe "a logged in user tries to GET a different user" do
    let(:user1) { FactoryBot.create :user }
    let(:user2) { FactoryBot.create :user }
    it "returns status forbidden" do
      login_as user1
      get "/users/#{user2.id}"
      expect(response).to have_http_status(:forbidden)
    end
  end
end
