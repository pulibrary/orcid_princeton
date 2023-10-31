# frozen_string_literal: true
require "rails_helper"

describe "user experience from start to finish", type: :system, js: true do
  context "a user without an orcid on file" do
    let(:user) { FactoryBot.create :user }
    let(:user2) { FactoryBot.create :user }
    let(:orcid_identifier) { (FactoryBot.build :user_with_orcid).orcid }
    it "walks the user through the process of entering an ORCID and creating a token" do
      login_as user

      # The user is redirected to the user edit screen after logging in.
      # The user has no orcid identifier or token yet.
      # The page should be accessible.
      visit "/"
      expect(page).to be_axe_clean
        .according_to(:wcag2a, :wcag2aa, :wcag21a, :wcag21aa, :section508)
        .skipping(:'color-contrast')
      expect(page).to have_content(user.display_name)
      click_on "See your profile"
      expect(page).to have_content "Welcome, #{user.display_name}"
      expect(page).to be_axe_clean
        .according_to(:wcag2a, :wcag2aa, :wcag21a, :wcag21aa, :section508)
        .skipping(:'color-contrast')

      expect(page).to have_content "This application is asking you to add Princeton University"
      expect(page).to have_button "Create or connect your ORCID iD"

      # Trying to access the page of another user should be forbidden.
      visit "/users/#{user2.id}"
      expect(page).to have_content "Forbidden"
      expect(page).to be_axe_clean
        .according_to(:wcag2a, :wcag2aa, :wcag21a, :wcag21aa, :section508)
        .skipping(:'color-contrast')
    end
  end
  context "when a user has an expired token" do
    let(:user) { FactoryBot.create :user_with_expired_token }
    it "lets them know their token is expired" do
      login_as user
      visit "/users/#{user.id}"
      expect(page).to have_content "Your ORCID token has expired"
    end
  end
end
