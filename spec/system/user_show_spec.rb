# frozen_string_literal: true
require "rails_helper"

describe "user show screen", type: :system, js: true do
  context "with a fully populated account" do
    let(:user) { FactoryBot.create :user_with_orcid_and_token }

    before do
      stub_request(:get, "https://api.sandbox.orcid.org/v3.0/#{user.orcid}/record").
      with(
        headers: {
        'Accept'=>'application/json',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'Authorization'=>"Bearer #{user.tokens.first.token}",
        'User-Agent'=>'Ruby'
        }).
      to_return(status: 401, body: "", headers: {}) # HTTP 401 means the token is not valid anymore
    end

    it "shows the user's account information" do
      login_as user
      visit "/users/#{user.id}"
      expect(page).to have_content("https://orcid.org/#{user.orcid}")
    end

    it "it allows a user to revoke linking to ORCiD" do
      login_as user
      visit "/users/#{user.id}"
      # user has linked their account to ORCiD
      expect(page).to have_content("https://orcid.org/#{user.orcid}")
      click_on "Check Authentication to ORCiD"
      # account is not linked anymore
      expect(page).to have_content("Connect your ORCID iD")
    end
  end
end
