# frozen_string_literal: true

# config valid for current version and patch releases of Capistrano
lock "~> 3.0"

set :application, "orcid_princeton"
set :repo_url, "https://github.com/pulibrary/orcid_princeton.git"

set :linked_dirs, %w[log public/system public/vite node_modules]

# Default branch is :main
set :branch, ENV["BRANCH"] || "main"

set :deploy_to, "/opt/orcid_princeton"

# Must match `ViteRuby.config.public_output_dir`, which by default is 'vite'
set :assets_prefix, "vite"

namespace :application do
  # You can/ should apply this command to a single host
  # cap --hosts=orcid-staging1.princeton.edu staging application:remove_from_nginx
  desc "Marks the server(s) to be removed from the loadbalancer"
  task :remove_from_nginx do
    count = 0
    on roles(:app) do
      count += 1
    end
    if count > (roles(:app).length / 2)
      raise "You must run this command on no more than half the servers utilizing the --hosts= switch"
    end
    on roles(:app) do
      within release_path do
        execute :touch, "public/remove-from-nginx"
      end
    end
  end

  # You can/ should apply this command to a single host
  # cap --hosts=orcid-staging1.princeton.edu staging application:serve_from_nginx
  desc "Marks the server(s) to be added back to the loadbalancer"
  task :serve_from_nginx do
    on roles(:app) do
      within release_path do
        execute :rm, "-f public/remove-from-nginx"
      end
    end
  end
end

# Workaround for this issue: https://github.com/capistrano/rails/issues/235
Rake::Task["deploy:assets:backup_manifest"].clear_actions
Rake::Task["deploy:assets:restore_manifest"].clear_actions

before "deploy:reverted", "deploy:assets:precompile"

before "deploy:compile_assets", "deploy:clobber_assets"
