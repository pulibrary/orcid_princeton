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
end
