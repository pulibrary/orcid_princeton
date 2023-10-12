# frozen_string_literal: true
FactoryBot.define do
  factory :user do
    sequence(:uid) { "uid#{srand}" }
    provider { "cas" }
  end
end
