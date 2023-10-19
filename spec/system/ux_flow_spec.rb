# frozen_string_literal: true
require "rails_helper"

describe "user experience from start to finish", type: :system, js: true do
  context "a user without an orcid on file" do
    let(:user) { FactoryBot.create :user }
    let(:orcid_identifier) { (FactoryBot.build :user_with_orcid).orcid }
    it "walks the user through the process of entering an ORCID and creating a token" do
      login_as user

      # The user is redirected to the user edit screen after logging in.
      # The user has no orcid identifier or token yet.
      # The page should be accessible.
      visit "/users/#{user.id}"
      expect(page).to have_content "Welcome, #{user.display_name}"
      expect(page).to have_content "You do not have an ORCID iD associated with your account yet."
      expect(page).to be_axe_clean
        .according_to(:wcag2a, :wcag2aa, :wcag21a, :wcag21aa, :section508)
        .skipping(:'color-contrast')

      # The user clicks the link to add an orcid identifier.
      # The user is redirected to the user edit screen.
      # The user enters an orcid identifier.
      # The user clicks the button to update their user record.
      # This edit form should be accessible.
      page.find(".edit-user-link").click
      fill_in "Orcid", with: orcid_identifier
      expect(page).to be_axe_clean
        .according_to(:wcag2a, :wcag2aa, :wcag21a, :wcag21aa, :section508)
        .skipping(:'color-contrast')
      click_button "Update User"
      # Now the user has an orcid identifier but no token
      expect(page).to have_content "Authenticate to ORCID.org"
      expect(page).to be_axe_clean
        .according_to(:wcag2a, :wcag2aa, :wcag21a, :wcag21aa, :section508)
        .skipping(:'color-contrast')
    end
  end
end
