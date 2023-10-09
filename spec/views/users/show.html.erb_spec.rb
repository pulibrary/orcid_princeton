# frozen_string_literal: true
require "rails_helper"

RSpec.describe "users/show", type: :view do
  before(:each) do
    assign(:user, User.create!(
      uid: "Uid",
      provider: "Provider",
      orcid: "0000000419369078",
      given_name: "Given Name",
      family_name: "Family Name",
      display_name: "Display Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Uid/)
    expect(rendered).to match(/Provider/)
    expect(rendered).to match(/Orcid/)
    expect(rendered).to match(/Given Name/)
    expect(rendered).to match(/Family Name/)
    expect(rendered).to match(/Display Name/)
  end
end
