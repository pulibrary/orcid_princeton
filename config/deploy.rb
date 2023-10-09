# frozen_string_literal: true
# config valid for current version and patch releases of Capistrano
lock "~> 3.17.3"

set :application, "pdc_orcid"
set :repo_url, "https://github.com/pulibrary/pdc_orcid.git"

set :linked_dirs, %w[log public/system public/assets]

# Default branch is :main
set :branch, ENV["BRANCH"] || "main"

set :deploy_to, "/opt/pdc_orcid"

# Must match `ViteRuby.config.public_output_dir`, which by default is 'vite'
set :assets_prefix, "vite"
