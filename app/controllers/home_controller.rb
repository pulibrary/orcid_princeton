# frozen_string_literal: true
require "securerandom"

class HomeController < ApplicationController
  skip_before_action :authenticate_user!
  def index; end

  def orcid_report
    report = PeopleSoftReport.new
    date = Time.zone.now.strftime("%Y-%m-%d")
    user_filename = "ORCID_portal_report_#{date}.csv"
    tmp_filename = "./tmp/#{SecureRandom.uuid}.csv"
    report.save_csv(tmp_filename)
    send_file tmp_filename, filename: user_filename
  end
end
