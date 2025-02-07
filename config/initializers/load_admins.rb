# frozen_string_literal: true
module OrcidPrinceton
  class Application < Rails::Application
    config.admins = config_for(:admins)
  end
end
