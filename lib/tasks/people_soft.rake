# frozen_string_literal: true
namespace :people_soft do
  desc "Saves a CSV report for PeopleSoft"
  task :report, [:filename] => [:environment] do |_, args|
    filename = args[:filename]
    raise "Must provide a filename" if filename.nil?
    report = PeopleSoftReport.new
    report.save_csv(filename)
  end

  desc "Saves the CSV report in the correct location for the environment"
  task cron_report: :environment do
    report = PeopleSoftReport.new
    report.save_csv(Rails.configuration.peoplesoft.output_location)
  end
end
