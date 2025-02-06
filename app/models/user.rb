# frozen_string_literal: true
require "devise"

class User < ApplicationRecord
  devise :omniauthable, omniauth_providers: [:cas, :orcid]
  has_many :tokens, dependent: :destroy

  validates :uid, presence: true
  validate do |user|
    user.orcid&.strip!
    if user.orcid.present? && !ISNI.valid?(user.orcid)
      user.errors.add :base, "Invalid format for ORCID"
    end
  end

  def self.from_cas(access_token)
    user = User.find_by(uid: access_token.uid)
    # create and persist the new model
    if user.nil?
      user = User.new(uid: access_token.uid, university_id: access_token.universityid)
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
    self.university_id = access_token.extra.universityid || access_token.universityid # "999999999"
    save!
  end

  # Are all of this user's tokens expired?
  # returns true or false
  def tokens_expired?
    tokens.all?(&:expired?)
  end

  def valid_token
    return nil if tokens_expired?
    valid_tokens = tokens.reject(&:expired?)
    valid_tokens.first
  end

  # Revokes tokens that ORCiD reports as not valid anymore
  def revoke_invalid_tokens
    now = DateTime.now
    tokens.where("expiration > ?", now).find_each do |token|
      if Token.valid_in_orcid?(token.token, orcid) == false
        token.expiration = now
        token.save!
      end
    end
  end

  # The following does not work for cases where ActiveRecord dynamically creates method names
  # alias_method :universityid, :university_id
  def universityid
    university_id
  end
end
