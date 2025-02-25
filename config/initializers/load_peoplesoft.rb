# frozen_string_literal: true
module OrcidPrinceton
  class Application < Rails::Application
    config.peoplesoft = config_for(:peoplesoft)
  end
end
