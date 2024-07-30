# frozen_string_literal: true
require "rails_helper"

RSpec.feature "home/index.html.erb", type: ["feature", "system"] do
  pending "add some examples to (or delete) #{__FILE__}"

  describe "displays correct homepage message" do
    let(:user) { FactoryBot.create :user_with_orcid_and_token }

    it "displays prompt to log in message" do
      visit "/home/index" # root
      expect(page).to have_content("Connect your ORCID id to Princeton so that published works can be easily identified as belonging to all Princeton researchers.")
      expect(page).to have_content("Log-in")
    end

    it "displays already signed in message" do
      login_as user
      visit "/home/index" # root
      expect(page).to have_content("Hello, " + user.given_name + "!")
      expect(page).to have_content("Go to your Profile Page to view your account.")
      expect(page).to have_link "Profile Page", href: "/users/" + user.id.to_s
      expect(page).to have_no_content("Log-in")
    end
  end
end
