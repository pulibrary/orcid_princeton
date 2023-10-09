# frozen_string_literal: true
require "rails_helper"

RSpec.describe User, type: :model do
  # this test is redundant since we know rails will do this for us,
  #  but is nice to have becuase it shows up all the attributes you can set on User
  it "stores optional parameters" do
    user = User.create(uid: "abc", orcid: "0000000419369078", given_name: "Jane", family_name: "Doe", display_name: "Jane Doe", provider: "test")
    user = user.reload
    expect(user.uid).to eq("abc")
    expect(user.orcid).to eq("0000000419369078")
    expect(user.given_name).to eq("Jane")
    expect(user.family_name).to eq("Doe")
    expect(user.display_name).to eq("Jane Doe")
    expect(user.provider).to eq("test")
  end

  it "a uid is required" do
    user = User.create
    expect(user.id).to be_nil
  end

  it "allows an orcid to be optional" do
    user = User.create(uid: "abc")
    expect(user.id).not_to be_nil
    user.orcid = "0000000419369078"
    user.save
    expect(user.reload.orcid).to eq("0000000419369078")
  end

  it "validates the orcid" do
    user = User.create(uid: "abc", orcid: "000000041936907")
    expect(user.id).to be_nil
    expect(user.errors.count).to eq(1)
    expect(user.errors.first.message).to eq("Invalid format for ORCID")
  end
end
