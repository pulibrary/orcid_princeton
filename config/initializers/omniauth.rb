# frozen_string_literal: true
require "omniauth-orcid"

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :orcid, ENV["ORCID_CLIENT_ID"], ENV["ORCID_CLIENT_SECRET"]
end
