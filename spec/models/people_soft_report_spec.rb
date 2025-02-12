# frozen_string_literal: true
require "rails_helper"

RSpec.describe PeopleSoftReport, type: :model do
  let(:user_valid) { FactoryBot.create(:user_with_orcid_and_token, university_id: "111345") }
  let(:user_valid2) { FactoryBot.create(:user_with_orcid_and_token, university_id: "67890") }
  let(:user_invalid) { FactoryBot.create(:user_with_expired_token, university_id: "223344") }
  let(:file_name) { "./tmp/#{FFaker::Color.name}#{Random.rand(10_000)}.csv" }
  before do
    user_valid
    user_valid2
    user_invalid
  end

  it "includes only valid users" do
    report = PeopleSoftReport.new
    expect(report.data.count).to be 2
    expect(report.data.index { |row| row.netid == user_invalid.uid }).to be nil
  end

  it "it saves the report to a file with the correct header" do
    report = PeopleSoftReport.new
    report.save_csv(file_name)
    expect(File.exist?(file_name)).to be true
    expect(File.readlines(file_name).first).to eq "University ID,Net ID,Full Name,Identifier Type,ORCID iD,Date Effective,Effective Until\n"
  end
end
