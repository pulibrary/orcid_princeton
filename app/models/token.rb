# frozen_string_literal: true
class Token < ApplicationRecord
  encrypts :token

  belongs_to :user

  # Create a token from an omniauth hash.
  # @param credentials [OmniAuth::AuthHash] The credentials hash from the omniauth response.
  # @param user [User] The user to associate the token with.
  # @return [Token] The token that was created.
  def self.create_from_omniauth(credentials, user)
    create(
      token: credentials.token,
      expiration: Time.zone.at(credentials.expires_at),
      user:
      # TODO: ADD REFRESH TOKEN
      # refresh_token: credentials.refresh_token
    )
  end

  # Check if the token has expired.
  # @return [Boolean] true if the token has expired, false otherwise.
  def expired?
    expiration < Time.zone.now
  end

  # Checks is a token is still valid with ORCiD
  # A token can become invalid if the user revokes it within ORCiD
  def self.valid_in_orcid?(token, orcid)
    url = "#{Rails.application.config.orcid[:url]}/#{orcid}/record"
    headers = {
      "Accept" => "application/json",
      "Authorization" => "Bearer #{token}"
    }
    response = HTTParty.get(url, headers:)
    return true if response.code == 200

    # Assume it's invalid for all other statuses.
    # We could also look inside response.parsed_response for other errors if need to.
    false
  end
end
