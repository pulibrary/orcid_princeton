# frozen_string_literal: true
require "rails_helper"

RSpec.describe OrcidApiStatus, type: :model do
  before do
    stub_request(:get, "https://api.orcid.org/v3.0/apiStatus")
      .with(
      headers: {
        "Accept" => "*/*",
        "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
        "User-Agent" => "Ruby"
      }
    )
      .to_return(status: 200, body: '{"tomcatUp":true,"dbConnectionOk":true,"readOnlyDbConnectionOk":true,"overallOk":true}', headers: {})
  end

  it "checks the status" do
    status = described_class.new
    expect { status.check! }.not_to raise_error
  end
end
