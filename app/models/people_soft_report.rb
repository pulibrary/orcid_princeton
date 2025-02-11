# frozen_string_literal: true
require "csv"

class PeopleSoftReport

  def initialize
    data = nil
  end

  def save_csv(filename)
    CSV.open(filename, "w") do |csv|
      csv << ["University ID", "Net ID", "Full Name", "Identifier Type", "ORCID iD", "Date Effective", "Effective Until"]
      data.each do |row|
        csv << [row.university_id, row.netid, row.full_name, row.row_type, row.orcid, row.effective_from_formatted, row.effective_until_formatted]
      end
    end
  end

  def data
    @data || begin
      rows = []
      User.all.each do |user|
        next if user.valid_token.nil?
        row = PeopleSoftRow.new
        row.university_id = user.university_id
        row.row_type = "ORC"
        row.netid = user.uid
        row.full_name = user.display_name
        row.orcid = user.orcid
        row.effective_from = user.valid_token.created_at
        row.effective_until = user.valid_token.expiration
        rows << row
      end
      rows
    end
  end
end
