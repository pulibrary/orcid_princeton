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
    expect(user.persisted?).to be false
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
    let(:university_id) { "999999999" }
    let(:access_token_full_extras) do
      OmniAuth::AuthHash.new(provider: "cas", uid: "test123",
                             extra: OmniAuth::AuthHash.new(mail: "who@princeton.edu", user: "test123", authnContextClass: "mfa-duo",
                                                           campusid: "who.areyou", puresidentdepartmentnumber: "41999",
                                                           title: "The Developer, Library - Information Technology.", uid: "test123",
                                                           universityid: university_id, displayname: "Areyou, Who", pudisplayname: "Areyou, Who",
                                                           edupersonaffiliation: "staff", givenname: "Who",
                                                           sn: "Areyou", department: "Library - Information Technology",
                                                           edupersonprincipalname: "who@princeton.edu",
                                                           puresidentdepartment: "Library - Information Technology",
                                                           puaffiliation: "stf", departmentnumber: "41999", pustatus: "stf"))
    end

    let(:access_token_blank_provider) do
      OmniAuth::AuthHash.new(provider: nil, uid: "test1234", extra: OmniAuth::AuthHash.new(
                            mail: "test@princeton.edu", user: "test1234", authnContextClass: "mfa-duo",
                            campusid: "test.person", puresidentdepartmentnumber: "41999",
                            title: "The Developer II, Library - Information Technology.", uid: "test1234",
                            universityid: "888888888", displayname: "Person, Test", pudisplayname: "Person, Test",
                            edupersonaffiliation: "staff", givenname: "Test",
                            sn: "Person", department: "Library - Information Technology",
                            edupersonprincipalname: "test@princeton.edu",
                            puresidentdepartment: "Library - Information Technology",
                            puaffiliation: "stf", departmentnumber: "41999", pustatus: "stf"
                          ))
    end

    it "returns a user object with name values set" do
      user = described_class.from_cas(access_token_full_extras)
      expect(user).to be_a described_class
      expect(user.given_name).to eq("Who")
      expect(user.family_name).to eq("Areyou")
      expect(user.display_name).to eq("Areyou, Who")
      expect(user.email).to eq("who@princeton.edu")
    end

    it "returns a user object with name values set when provider is blank" do
      user = User.create(uid: "test1234")
      user.save
      user = described_class.from_cas(access_token_blank_provider)
      expect(user).to be_a described_class
      expect(user.given_name).to eq("Test")
      expect(user.family_name).to eq("Person")
      expect(user.display_name).to eq("Person, Test")
      expect(user.email).to eq("test@princeton.edu")
    end

    it "creates a User with a `university_id`" do
      user = described_class.from_cas(access_token_full_extras)

      expect(user.persisted?).to be true
      expect(user.university_id).to eq university_id
    end
  end

  describe "#universityid" do
    let(:user) { FactoryBot.create(:user_with_university_id) }

    it "aliases for #university_id" do
      expect(user.universityid).to eq(user.university_id)
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

  # return the unexpired token
  describe "#valid_token" do
    describe "when the user has an unexpired token" do
      let(:user) { FactoryBot.create(:user_with_orcid_and_token) }
      it "returns false" do
        expect(user.valid_token).to eq(user.tokens.first)
      end
    end
    describe "when the user has no unexpired tokens" do
      let(:user) { FactoryBot.create(:user_with_expired_token) }
      it "returns true" do
        expect(user.valid_token).to be_nil
      end
    end
    describe "when the user has an expired and unexpired token" do
      let(:user) { FactoryBot.create(:user_with_expired_token) }
      let(:second_token) { FactoryBot.create(:token, user:) }
      it "returns true" do
        second_token # make sure the second token exists
        expect(user.valid_token).to eq(second_token)
      end
    end
  end

  describe "#revoke_invalid_tokens" do
    context "when token has been revoked from ORCiD" do
      let(:user) { FactoryBot.create(:user_with_orcid_and_token) }

      before do
        stub_request(:get, "https://api.sandbox.orcid.org/v3.0/#{user.orcid}/record")
          .with(
          headers: {
            "Accept" => "application/json",
            "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
            "Authorization" => "Bearer #{user.tokens.first.token}",
            "User-Agent" => "Ruby"
          }
        )
          .to_return(status: 401, body: "", headers: {}) # HTTP 401 means that token has been revoked
      end

      it "it expires the invalid tokes" do
        expect(user.valid_token).to_not be nil
        user.revoke_invalid_tokens
        user.reload
        expect(user.valid_token).to be nil
      end
    end

    context "when token is still valid in ORCiD" do
      let(:user) { FactoryBot.create(:user_with_orcid_and_token) }

      before do
        stub_request(:get, "https://api.sandbox.orcid.org/v3.0/#{user.orcid}/record")
          .with(
          headers: {
            "Accept" => "application/json",
            "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
            "Authorization" => "Bearer #{user.tokens.first.token}",
            "User-Agent" => "Ruby"
          }
        )
          .to_return(status: 200, body: "", headers: {}) # HTTP 200 means the token is still valid
      end

      it "preserves the token" do
        expect(user.valid_token).to_not be nil
        user.revoke_invalid_tokens
        user.reload
        expect(user.valid_token).to_not be nil
      end
    end
  end

  describe "#admin?" do
    let(:user) { FactoryBot.create(:user) }
    let(:admin) { FactoryBot.create(:admin) }

    it "determines whether or not a User is an admin user" do
      expect(user.admin?).to be false
      expect(admin.admin?).to be true
    end
  end

  describe ".create_default_users" do
    let(:users) { described_class.all }

    before do
    end

    it "creates configured User models with the necessary Roles" do
      expect(users).to be_empty
      described_class.create_default_users
      expect(users).not_to be_empty

      models = users.to_a
      admins = models.select(&:admin?)
      expect(admins.length).to eq(8)

      non_admins = models.reject(&:admin?)
      expect(non_admins).to be_empty
    end
  end
end
