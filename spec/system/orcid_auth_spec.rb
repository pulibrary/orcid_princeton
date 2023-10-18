# frozen_string_literal: true
require "rails_helper"

describe "authenticate to orcid", type: :system, js: true do
  context "a user without an orcid on file" do
    let(:user) { FactoryBot.create :user }
    it "prompts the user to enter their iD or register with ORCID" do
      login_as user
      visit "/orcids/#{user.id}"
      expect(page).to have_content "Welcome, #{user.display_name}"
      expect(page).to have_content "If you have an ORCID iD"
      expect(page).to have_content "If you do not yet have an ORCID iD"
      expect(page).to be_axe_clean
        .according_to(:wcag2a, :wcag2aa, :wcag21a, :wcag21aa, :section508)
        .skipping(:'color-contrast')
    end
  end

  context "a user with an orcid on file" do
    let(:user) { FactoryBot.create :user_with_orcid }
    it "prompts the user to authenticate to ORCID.org" do
      login_as user
      visit "/orcids/#{user.id}"
      expect(page).to have_content "Welcome, #{user.display_name}"
      expect(page).to have_content user.orcid
      expect(page).to have_content "Authenticate to ORCID.org"
      expect(page).to be_axe_clean
        .according_to(:wcag2a, :wcag2aa, :wcag21a, :wcag21aa, :section508)
        .skipping(:'color-contrast')
    end
  end
end
