# frozen_string_literal: true
require "byebug"

FactoryBot.define do
  factory :user do
    sequence(:uid) { "uid#{srand}" }
    provider { "cas" }
    given_name { FFaker::Name.first_name }
    family_name { FFaker::Name.last_name }
    display_name { "#{given_name} #{family_name}" }

    factory :user_with_orcid do
      # Follow the rules defined in https://support.orcid.org/hc/en-us/articles/360006897674-Structure-of-the-ORCID-Identifier
      # to generate a valid (but fake) ORCID number.
      sequence :orcid do |n|
        # Start with the base orcid number. Add 1 every time we run the factory.
        # This will ensure the number is always unique. (As opposed to using random, which has some chance of collision.)
        orcid_start = 150_000_007
        raw_orcid = (orcid_start + n).to_s

        # Calculate the check digit
        number_array = raw_orcid.to_s.chars
        total = 0
        number_array.each_with_index do |number, _index|
          total = (total + number.to_i) * 2
        end
        remainder = total % 11
        result = (12 - remainder) % 11
        check_digit = result == 10 ? "X" : result.to_s

        # Add the check digit to the end of the number
        number_array << check_digit

        # Pad the front of the number with zeros until it is 16 digits long
        # Format the ORCID identifier with dashes between each 4 digits
        number_array.join.rjust(16, "0").chars.each_slice(4).map(&:join).join("-")
      end
    end
  end
end
