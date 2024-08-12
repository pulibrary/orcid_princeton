# frozen_string_literal: true
require "rails_helper"

# Specs in this file have access to a helper object that includes
# the UsersHelper. For example:
#
# describe UsersHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe BannerHelper, type: :helper do

    describe "#orcid_available?" do

    # ORCID API request is stubbed in RailsHelper 
    
    it "returns true if the ORCID API is available" do
        expect(self.orcid_available?).to eq(true)
    end
  end

end