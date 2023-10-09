# frozen_string_literal: true
require "rails_helper"

RSpec.describe "users/new", type: :view do
  before(:each) do
    assign(:user, User.new(
      uid: "MyString",
      provider: "MyString",
      orcid: "MyString",
      given_name: "MyString",
      family_name: "MyString",
      display_name: "MyString"
    ))
  end

  it "renders new user form" do
    render

    assert_select "form[action=?][method=?]", users_path, "post" do
      assert_select "input[name=?]", "user[uid]"

      assert_select "input[name=?]", "user[provider]"

      assert_select "input[name=?]", "user[orcid]"

      assert_select "input[name=?]", "user[given_name]"

      assert_select "input[name=?]", "user[family_name]"

      assert_select "input[name=?]", "user[display_name]"
    end
  end
end
