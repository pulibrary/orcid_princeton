# frozen_string_literal: true
# config valid for current version and patch releases of Capistrano
lock "~> 3.17.3"

set :application, "orcid_princeton"
set :repo_url, "https://github.com/pulibrary/orcid_princeton.git"

set :linked_dirs, %w[log public/system public/assets node_modules]

# Default branch is :main
set :branch, ENV["BRANCH"] || "main"

set :deploy_to, "/opt/orcid_princeton"

# Must match `ViteRuby.config.public_output_dir`, which by default is 'vite'
set :assets_prefix, "vite"
