# frozen_string_literal: true
class Token < ApplicationRecord
  encrypts :token

  belongs_to :user
end
