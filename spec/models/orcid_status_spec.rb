# frozen_string_literal: true
require "rails_helper"

RSpec.describe OrcidApiStatus, type: :model do
  it "checks the status" do
    status = described_class.new
    expect { status.check! }.not_to raise_error
  end

  context "when the api is showing a failed componant" do
    let(:ok) { instance_double(Net::HTTPOK, code: "200", body: "{\"tomcatUp\":false,\"dbConnectionOk\":true,\"readOnlyDbConnectionOk\":true,\"overallOk\":true}") }
    let(:stub) { instance_double(Net::HTTP, "use_ssl=": true, "read_timeout=": true, get: ok) }
    before do
      allow(Net::HTTP).to receive(:new).and_return(stub)
    end
    it "raises an error when the status is checked" do
      status = described_class.new
      expect { status.check! }.to raise_error(RuntimeError, "The ORCID API has an invalid status https://api.orcid.org/v3.0/apiStatus")
    end
  end

  context "when the api errors" do
    let(:bad) { instance_double(Net::HTTPBadGateway, code: "502") }
    let(:stub) { instance_double(Net::HTTP, "use_ssl=": true, "read_timeout=": true, get: bad) }
    before do
      allow(Net::HTTP).to receive(:new).and_return(stub)
    end
    it "raises an error when the status is checked" do
      status = described_class.new
      expect { status.check! }.to raise_error(RuntimeError, "The ORCID API returned HTTP error code: 502")
    end
  end

  context "when the api errors and then is ok" do
    let(:stub) { instance_double(Net::HTTP, "use_ssl=": true, "read_timeout=": true) }
    let(:bad) { instance_double(Net::HTTPBadGateway, code: "502") }
    let(:ok) { instance_double(Net::HTTPOK, code: "200", body: "{\"tomcatUp\":true,\"dbConnectionOk\":true,\"readOnlyDbConnectionOk\":true,\"overallOk\":true}") }
    before do
      allow(Net::HTTP).to receive(:new).and_return(stub)
      allow(stub).to receive(:get).and_return(bad, ok)
    end
    it "does not raise an error when the status is checked" do
      status = described_class.new
      expect { status.check! }.not_to raise_error
    end
  end
end
