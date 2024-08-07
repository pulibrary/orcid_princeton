# frozen_string_literal: true
module OrcidPrinceton
  class Application < Rails::Application
    config.orcid = config_for(:orcid)
  end
end
