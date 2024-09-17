# frozen_string_literal: true
require "rails_helper"

RSpec.describe OrcidApiStatus, type: :model do
  it "checks the status" do
    status = described_class.new
    expect { status.check! }.not_to raise_error
  end
end
