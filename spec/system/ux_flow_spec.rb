# frozen_string_literal: true
require "rails_helper"

describe "user experience from start to finish", type: :system, js: true do
  context "a user without an orcid on file" do
    let(:user) { FactoryBot.create :user }
    it "walks the user through the process of entering an ORCID and creating a token" do
      login_as user
      visit "/"
      expect(page).to have_content "Welcome, #{user.display_name}"
      expect(page).to have_content "If you have an ORCID iD"
      expect(page).to have_content "If you do not yet have an ORCID iD"
      expect(page).to be_axe_clean
        .according_to(:wcag2a, :wcag2aa, :wcag21a, :wcag21aa, :section508)
        .skipping(:'color-contrast')
    end
  end
end
