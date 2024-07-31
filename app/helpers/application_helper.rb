# frozen_string_literal: true
module ApplicationHelper
  def plausible_partial
    return "shared/plausible_dev_staging" if Rails.env.development? || Rails.env.staging?
    return "shared/plausible" if Rails.env.production?
  end
end
