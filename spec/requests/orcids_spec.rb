# frozen_string_literal: true
require "rails_helper"

RSpec.describe "Orcids", type: :request do
  let(:user) { FactoryBot.create :user }
  describe "GET /orcids/USER_ID" do
    it "gets the orcid page for the user" do
      login_as user
      get "/orcids/#{user.id}"
      expect(response).to have_http_status(:success)
    end
  end
end
