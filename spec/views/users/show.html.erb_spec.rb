# frozen_string_literal: true
require "rails_helper"

RSpec.describe "users/show", type: :view do
  let(:user) do
    User.create!(
    uid: "Uid",
    provider: "Provider",
    orcid: "0000000419369078",
    given_name: "Given Name",
    family_name: "Family Name",
    display_name: "Display Name"
  )
  end

  let(:token) do
    Token.create!(
      user_id: user.id,
      token_type: "test-type",
      token: "123-123",
      expiration: DateTime.tomorrow,
      scope: "test-scope"
    )
  end

  before(:each) do
    assign(:user, user)
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

  it "includes tokens when available" do
    user.tokens << token
    user.save!
    render
    expect(rendered).to match(/Uid/)
    expect(rendered).to match(/ORCiD tokens/)
  end
end
