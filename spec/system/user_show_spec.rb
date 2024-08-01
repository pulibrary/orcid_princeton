# frozen_string_literal: true
require "rails_helper"

describe "user show screen", type: :system, js: true do
  context "with a fully populated account" do
    let(:user) { FactoryBot.create :user_with_orcid_and_token }
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
      click_on "Revoke Authentication"
      page.driver.browser.switch_to.alert.accept
      # account is not linked anymore
      expect(page).to have_content("Connect your ORCID iD")
    end
  end
end
