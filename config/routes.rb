# frozen_string_literal: true
Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  mount HealthMonitor::Engine, at: "/"

  # Branded error pages
  match "/403", to: "errors#forbidden", via: :all
  match "/404", to: "errors#not_found", via: :all
  match "/500", to: "errors#internal_server_error", via: :all

  resources :users, only: [:show]

  get "orcids/:id", to: "orcids#show", as: :orcid_show
  match "/auth/orcid/callback", to: "orcids#create", via: [:get, :post]

  get "home/index"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  root "home#index"

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  devise_scope :user do
    get "sign_in", to: "home#index"
    get "sign_in", to: "users/omniauth_callbacks#passthru", as: :session
    get "sign_out", to: "devise/sessions#destroy", as: :destroy_user_session
    post ":id/validate-tokens", to: "users#validate_tokens", as: :validate_tokens
  end
end
