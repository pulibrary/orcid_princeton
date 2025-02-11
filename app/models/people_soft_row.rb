# frozen_string_literal: true

class PeopleSoftRow
  attr_accessor :university_id, :row_type, :netid, :full_name, :orcid, :effective_from, :effective_until

  def effective_from_formatted
    return nil if effective_from.nil?
    effective_from.strftime("%m/%d/%Y")
  end

  def effective_until_formatted
    return nil if effective_until.nil?
    effective_until.strftime("%m/%d/%Y")
  end
end
