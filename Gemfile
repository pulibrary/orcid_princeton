# frozen_string_literal: true
source "https://rubygems.org"

ruby "3.4.2"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.2.0"

gem "bcrypt_pbkdf"
gem "bootsnap", require: false
gem "ed25519"
# Pinning to 12.4.0 due to Rails 7.1 compatibility issue in 12.4.1
gem "health-monitor-rails", "12.5.0"
gem "honeybadger"
gem "httparty"
gem "isni"
gem "jbuilder"
gem "oauth2", "~> 2.0.x"
gem "omniauth", "~> 2.1", ">= 2.1.2"
gem "omniauth-orcid"
gem "omniauth-rails_csrf_protection"
gem "pg"
gem "puma", "6.6.0"
gem "rack", "2.2.11"
gem "rails-controller-testing"
gem "rbnacl"
gem "simplecov"
gem "vite_rails"
gem "vite_ruby"
gem "whenever"

gem "net-ldap"
gem "sul_orcid_client"

# Single sign on
gem "devise", "~> 4.9"
gem "omniauth-cas", "~> 3.0"

group :development, :test do
  gem "bixby"
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[mri windows]
  gem "factory_bot_rails", require: false
  gem "ffaker"
  gem "rspec-rails"
end

group :development do
  gem "capistrano", "~> 3.19.0", require: false
  gem "capistrano-passenger", require: false
  gem "capistrano-rails", "~> 1.6", require: false
  gem "capistrano-yarn", require: false
  gem "pry-byebug"
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "axe-core-rspec"
  gem "capybara"
  gem "coveralls_reborn", require: false
  gem "database_cleaner-active_record"
  gem "selenium-webdriver"
  gem "webmock"
end

gem "rolify", "~> 6.0"
