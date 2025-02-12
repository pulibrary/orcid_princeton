# frozen_string_literal: true

class PeopleSoftRow
  attr_accessor :university_id, :row_type, :netid, :full_name, :orcid, :effective_from, :effective_until

  class << self
    def new_from_user(user)
      row = PeopleSoftRow.new
      row.university_id = user.university_id
      row.row_type = "ORC"
      row.netid = user.uid
      row.full_name = user.display_name
      row.orcid = user.orcid
      row.effective_from = user.valid_token.created_at.strftime("%m/%d/%Y")
      row.effective_until = user.valid_token.expiration.strftime("%m/%d/%Y")
      row
    end
  end
end
