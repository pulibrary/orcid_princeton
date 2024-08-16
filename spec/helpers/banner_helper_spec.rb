# frozen_string_literal: true
require "rails_helper"

RSpec.describe BannerHelper, type: :helper do
  describe "#orcid_available?" do
    # ORCID API request is stubbed in RailsHelper
    it "returns true if the ORCID API is available" do
      expect(orcid_available?).to eq(true)
    end
  end
end
