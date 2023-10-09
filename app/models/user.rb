# frozen_string_literal: true
class User < ApplicationRecord
  validates :uid, presence: true
  validate do |user|
    user.orcid&.strip!
    if user.orcid.present? && !ISNI.valid?(user.orcid)
      user.errors.add :base, "Invalid format for ORCID"
    end
  end
end
