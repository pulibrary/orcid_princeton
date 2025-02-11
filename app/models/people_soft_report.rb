# frozen_string_literal: true
require "csv"

class PeopleSoftReport
  def initialize
    @data = nil
  end

  def save_csv(filename)
    CSV.open(filename, "w") do |csv|
      csv << ["University ID", "Net ID", "Full Name", "Identifier Type", "ORCID iD", "Date Effective", "Effective Until"]
      data.each do |row|
        csv << [row.university_id, row.netid, row.full_name, row.row_type, row.orcid, row.effective_from, row.effective_until]
      end
    end
  end

  def data
    @data || begin
      rows = []
      User.all.find_each do |user|
        next if user.valid_token.nil?
        rows << PeopleSoftRow.new_from_user(user)
      end
      rows
    end
  end
end
