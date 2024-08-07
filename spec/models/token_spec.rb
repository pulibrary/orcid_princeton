# frozen_string_literal: true
require "rails_helper"

RSpec.describe Token, type: :model do
  let(:user) { FactoryBot.create(:user_with_orcid) }
  let(:omniauth_hash) do
    OmniAuth::AuthHash.new(credentials:, uid: user.orcid)
  end
  let(:credentials) do
    OmniAuth::AuthHash.new(
      expires: true,
      expires_at: 2_329_292_554,
      refresh_token: "4daad3c0-5bcd-4d39-b505-a515b32d2f87",
      token: "253e5364-eb30-4cbb-83be-3e5c9ce3b0bc"
    )
  end

  it "creates a token from an omniauth hash" do
    token = described_class.create_from_omniauth(credentials, user)
    expect(token).to be_a described_class
    expect(token.token).to eq("253e5364-eb30-4cbb-83be-3e5c9ce3b0bc")
    expect(token.expiration.to_i).to eq(2_329_292_554)
    expect(token.user).to eq(user)
    expect(token).to be_valid
    expect(token.id).to be_present
    # expect(token.refresh_token).to eq("4daad3c0-5bcd-4d39-b505-a515b32d2f87")
  end

  context "#expired?" do
    describe "when the expiration date is past" do
      let(:token) { FactoryBot.build(:expired_token) }
      it "returns true" do
        expect(token.expired?).to eq(true)
      end
    end
    describe "when the expiration date is in the future" do
      let(:token) { FactoryBot.build(:token) }
      it "returns false" do
        expect(token.expired?).to eq(false)
      end
    end
  end # context "#expired?"

  describe "#valid_in_orcid?" do
    it "calls out to the api to validate the request" do
      stub_request(:get, "https://api.sandbox.orcid.org/v3.0/#{user.orcid}/record").to_return(status: 200, body: "", headers: {})
      token = described_class.create_from_omniauth(credentials, user)
      expect(Token.valid_in_orcid?(token, user.orcid)).to eq(true)

      stub_request(:get, "https://api.sandbox.orcid.org/v3.0/#{user.orcid}/record").to_return(status: 401, body: "", headers: {})
      expect(Token.valid_in_orcid?(token, user.orcid)).to eq(false)
      expect(a_request(:get, "https://api.sandbox.orcid.org/v3.0/#{user.orcid}/record")).to have_been_made.twice
    end

    context "the url is configured differently" do
      it "calls out to the api to validate the request" do
        orig_url = Rails.application.config.orcid[:url]
        Rails.application.config.orcid[:url] = "https://api.orcid.org/v3.0"
        stub_request(:get, "https://api.orcid.org/v3.0/#{user.orcid}/record").to_return(status: 200, body: "", headers: {})
        token = described_class.create_from_omniauth(credentials, user)
        expect(Token.valid_in_orcid?(token, user.orcid)).to eq(true)

        stub_request(:get, "https://api.orcid.org/v3.0/#{user.orcid}/record").to_return(status: 401, body: "", headers: {})
        expect(Token.valid_in_orcid?(token, user.orcid)).to eq(false)
        expect(a_request(:get, "https://api.orcid.org/v3.0/#{user.orcid}/record")).to have_been_made.twice
        Rails.application.config.orcid[:url] = orig_url
      end
    end
  end
end
