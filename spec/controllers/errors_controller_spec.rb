require "rails_helper"

RSpec.describe ErrorsController, type: ["controller", "request"] do
  let(:user) { FactoryBot.create(:user, orcid: nil) }

  before do
    sign_in user
  end

  describe "#forbidden" do
    it "returns forbidden 403 http status" do
      get "/403"
      expect(response).to have_http_status(:forbidden)
    end
  end

  describe "#not_found" do
    it "returns page not found 404 http status" do
      get "/404"
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "#internal_server_error" do
    it "returns internal server error 500 http status" do
      get "/500"
      expect(response).to have_http_status(:internal_server_error)
    end
  end
end
