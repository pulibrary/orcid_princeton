# frozen_string_literal: true

FactoryBot.define do
  factory :token do
    token { "e82938fa-a287-42cf-a2ce-f48ef68c9a35" }
    user { FactoryBot.create :user_with_orcid }
    expiration { Time.zone.at(2_329_902_061) }

    factory :expired_token do
      expiration { Time.zone.at(1_698_165_083) }
    end
  end
end
