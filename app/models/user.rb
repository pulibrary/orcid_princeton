# frozen_string_literal: true
require "devise"

class User < ApplicationRecord
  devise :omniauthable

  validates :uid, presence: true
  validate do |user|
    user.orcid&.strip!
    if user.orcid.present? && !ISNI.valid?(user.orcid)
      user.errors.add :base, "Invalid format for ORCID"
    end
  end

  def self.from_cas(access_token)
    user = User.find_by(uid: access_token.uid)
    if user.nil?
      user = User.new(uid: access_token.uid)
      user.update_with_cas(access_token)
    elsif user.provider.blank?
      user.update_with_cas(access_token)
    end
    user
  end

  # Updates an existing User record with some information from CAS.
  def update_with_cas(access_token)
    self.provider = access_token.provider
    self.email = access_token.extra.mail
    self.given_name = access_token.extra.givenname || access_token.uid # Harriet
    self.family_name = access_token.extra.sn || access_token.uid # Tubman
    self.display_name = access_token.extra.displayname || access_token.uid # "Harriet Tubman"
    save!
  end
end
