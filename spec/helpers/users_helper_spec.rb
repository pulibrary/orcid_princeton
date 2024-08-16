# frozen_string_literal: true
require "rails_helper"

RSpec.describe UsersHelper, type: :helper do
  describe "#full_orcid_display" do
    user_without_orcid = User.create(uid: "abc")
    user_with_orcid = FactoryBot.create(:user_with_orcid_and_token)

    it "returns nothing if the user does not have an ORCID iD" do
      expect(full_orcid_display(user_without_orcid.orcid)).to eq(nil)
    end

    it "returns ORCID information if the user has an ORCID iD" do
      expect(full_orcid_display(user_with_orcid.orcid)).to contain("<a href=\"https://orcid.org/0000-0015-0000-0088\">https://orcid.org/0000-0015-0000-0088</a>")
    end
  end
end
