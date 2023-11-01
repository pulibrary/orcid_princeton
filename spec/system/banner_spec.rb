# frozen_string_literal: true
require "rails_helper"

describe "Website banner", type: :system, js: true do
  let(:user) { FactoryBot.create :user }
  it "has the banner on the homepage" do
    visit "/"
    expect(page).to have_css "#banner"
  end

  it "renders html tags in the banner" do
    visit "/"
    expect(page).not_to have_content "<i>test</i>"
    expect(page.find("header#banner h1 i").text).to eq "test"
    expect(page).not_to have_content "<b>test</b>"
    expect(page.find("header#banner p b").text).to eq "test"
    expect(page).to have_link "message", href: "mailto:fake@princeton.edu"
  end
end
