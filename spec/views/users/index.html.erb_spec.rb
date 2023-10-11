# frozen_string_literal: true
require "rails_helper"

RSpec.describe "users/index", type: :view do
  before(:each) do
    assign(:users, [
             User.create!(
               uid: "abc",
               provider: "Provider",
               orcid: "0000000419369078",
               given_name: "Given Name",
               family_name: "Family Name",
               display_name: "Display Name"
             ),
             User.create!(
               uid: "123",
               provider: "Provider",
               orcid: "0000000419369078",
               given_name: "Given Name",
               family_name: "Family Name",
               display_name: "Display Name"
             )
           ])
  end

  it "renders a list of users" do
    render
    cell_selector = Rails::VERSION::STRING >= "7" ? "div>p" : "tr>td"
    assert_select cell_selector, text: Regexp.new("abc".to_s), count: 1
    assert_select cell_selector, text: Regexp.new("123".to_s), count: 1
    assert_select cell_selector, text: Regexp.new("Provider".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("0000000419369078".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Given Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Family Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Display Name".to_s), count: 2
  end
end
