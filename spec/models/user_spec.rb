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

  describe "#from_cas" do
    let(:access_token_full_extras) do
      OmniAuth::AuthHash.new(provider: "cas", uid: "test123",
                             extra: OmniAuth::AuthHash.new(mail: "who@princeton.edu", user: "test123", authnContextClass: "mfa-duo",
                                                           campusid: "who.areyou", puresidentdepartmentnumber: "41999",
                                                           title: "The Developer, Library - Information Technology.", uid: "test123",
                                                           universityid: "999999999", displayname: "Areyou, Who", pudisplayname: "Areyou, Who",
                                                           edupersonaffiliation: "staff", givenname: "Who",
                                                           sn: "Areyou", department: "Library - Information Technology",
                                                           edupersonprincipalname: "who@princeton.edu",
                                                           puresidentdepartment: "Library - Information Technology",
                                                           puaffiliation: "stf", departmentnumber: "41999", pustatus: "stf"))
    end

    it "returns a user object with name values set" do
      user = described_class.from_cas(access_token_full_extras)
      expect(user).to be_a described_class
      expect(user.given_name).to eq("Who")
      expect(user.family_name).to eq("Areyou")
      expect(user.display_name).to eq("Areyou, Who")
      expect(user.email).to eq("who@princeton.edu")
    end
  end

  # If all of a user's tokens are expired, then the user should be prompted to make a new one.
  describe "#tokens_expired?" do
    describe "when the user has an unexpired token" do
      let(:user) { FactoryBot.create(:user_with_orcid_and_token) }
      it "returns false" do
        expect(user.tokens_expired?).to eq(false)
      end
    end
    describe "when the user has no unexpired tokens" do
      let(:user) { FactoryBot.create(:user_with_expired_token) }
      it "returns true" do
        expect(user.tokens_expired?).to eq(true)
      end
    end
  end
end
