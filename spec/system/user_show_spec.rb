# frozen_string_literal: true
require "rails_helper"

describe "user show screen", type: :system, js: true do
  context "with a fully populated account" do
    let(:user) { FactoryBot.create :user_with_orcid }
    it "shows the user's account information" do
      login_as user
      visit "/users/#{user.id}"
      byebug
    end
  end
end