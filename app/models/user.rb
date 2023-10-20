# frozen_string_literal: true
require "devise"

class User < ApplicationRecord
  devise :omniauthable
  has_many :tokens, dependent: :destroy

  validates :uid, presence: true
  validate do |user|
    user.orcid&.strip!
    if user.orcid.present? && !ISNI.valid?(user.orcid)
      user.errors.add :base, "Invalid format for ORCID"
    end
  end

  def self.fake_orcid
    orcid_low = 150_000_007
    orcid_high = 350_000_001
    raw_orcid = rand(orcid_low..orcid_high).to_s
    number_array = raw_orcid.to_s.chars
    total = 0
    number_array.each_with_index do |number, _index|
      total = (total + number.to_i) * 2
    end
    remainder = total % 11
    result = (12 - remainder) % 11
    check_digit = result == 10 ? "X" : result.to_s
    number_array << check_digit
    number_array.join.rjust(16, "0").chars.each_slice(4).map(&:join).join("-")
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
