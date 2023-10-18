# frozen_string_literal: true
FactoryBot.define do
  factory :user do
    sequence(:uid) { "uid#{srand}" }
    provider { "cas" }
    given_name { FFaker::Name.first_name }
    family_name { FFaker::Name.last_name }
    display_name { "#{given_name} #{family_name}" }
  end
end
