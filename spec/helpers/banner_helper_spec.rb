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
    before do
        stub_request(:get, "https://api.orcid.org/v3.0/apiStatus")
          .with(
          headers: {
            "Accept" => "*/*",
            "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
            "Host" => "api.orcid.org",
            "User-Agent" => "Ruby"
          }
        )
          .to_return(status: 200, body: '{"tomcatUp":true,"dbConnectionOk":true,"readOnlyDbConnectionOk":true,"overallOk":true}', headers: {})
    end
    
    it "returns true if the ORCID API is available" do
        expect(self.orcid_available?).to eq(true)
    end
  end

end