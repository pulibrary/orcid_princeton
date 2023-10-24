# frozen_string_literal: true
class Token < ApplicationRecord

  encrypts :token

  belongs_to :user

  def self.create_from_omniauth(credentials, user)
    create(
      token: credentials.token,
      expiration: Time.at(credentials.expires_at)
      # TODO: ADD REFRESH TOKEN
      # refresh_token: credentials.refresh_token
    )
  end
end
