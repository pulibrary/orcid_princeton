# frozen_string_literal: true
require "rails_helper"

RSpec.describe "users/edit", type: :view do
  let(:user) do
    User.create!(
      uid: "MyString",
      provider: "MyString",
      orcid: "0000000419369078",
      given_name: "MyString",
      family_name: "MyString",
      display_name: "MyString"
    )
  end

  before(:each) do
    assign(:user, user)
  end

  it "renders the edit user form" do
    render

    assert_select "form[action=?][method=?]", user_path(user), "post" do
      assert_select "input[name=?]", "user[uid]"

      assert_select "input[name=?]", "user[provider]"

      assert_select "input[name=?]", "user[orcid]"

      assert_select "input[name=?]", "user[given_name]"

      assert_select "input[name=?]", "user[family_name]"

      assert_select "input[name=?]", "user[display_name]"
    end
  end
end
