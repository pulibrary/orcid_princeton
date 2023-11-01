# frozen_string_literal: true
module OrcidPrinceton
  class Application < Rails::Application
    config.banner = config_for(:banner)
  end
end
