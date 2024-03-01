# frozen_string_literal: true
source "https://rubygems.org"

ruby "3.2.3"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.1.0"

gem "bcrypt_pbkdf"
gem "bootsnap", require: false
gem "ed25519"
gem "health-monitor-rails"
gem "honeybadger"
gem "isni"
gem "jbuilder"
gem "omniauth-orcid"
gem "pg"
gem "puma", "5.6.8"
gem "rack", "2.2.8.1"
gem "simplecov"
gem "vite_rails"
gem "vite_ruby"

gem "sul_orcid_client"

# Single sign on
gem "devise"
gem "omniauth-cas"

group :development, :test do
  gem "bixby"
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[mri windows]
  gem "factory_bot_rails", require: false
  gem "ffaker"
  gem "rspec-rails"
end

group :development do
  gem "byebug"
  gem "capistrano", "~> 3.10", require: false
  gem "capistrano-passenger", require: false
  gem "capistrano-rails", "~> 1.6", require: false
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "axe-core-rspec"
  gem "capybara"
  gem "database_cleaner-active_record"
  gem "selenium-webdriver"
end
