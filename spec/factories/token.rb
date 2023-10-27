# frozen_string_literal: true

FactoryBot.define do
  factory :token do
    token { "e82938fa-a287-42cf-a2ce-f48ef68c9a35" }
    expiration { Time.zone.at(1_979_903_874) }
    user { FactoryBot.create :user_with_orcid }
  end
end
