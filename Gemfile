# frozen_string_literal: true
source "https://rubygems.org"

ruby "3.2.0"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.1.0"

gem "bcrypt_pbkdf"
gem "bootsnap", require: false
gem "ed25519"
gem "isni"
gem "jbuilder"
gem "pg"
gem "puma", ">= 5.0"
gem "simplecov"
gem "vite_rails"
gem "vite_ruby"

group :development, :test do
  gem "bixby"
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[mri windows]
  gem "rspec-rails"
end

group :development do
  gem "capistrano", "~> 3.10", require: false
  gem "capistrano-passenger", require: false
  gem "capistrano-rails", "~> 1.6", require: false
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
end
