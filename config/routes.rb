# frozen_string_literal: true
Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  mount HealthMonitor::Engine, at: "/"

  resources :users, only: [:show]

  get "orcids/:id", to: "orcids#show", as: :orcid_show
  # match "/auth/orcid/callback", to: "users/omniauth_callbacks#orcid", via: [:get, :post]
  match "/auth/orcid/callback", to: "orcids#create", via: [:get, :post]
  # TODO: remove when we get the matching API key from ORCID
  match "/orcid_redirect", to: "orcids#create", via: [:get, :post]

  get "home/index"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  root "home#index"

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  devise_scope :user do
    get "sign_in", to: "devise/sessions#new", as: :new_user_session
    get "sign_out", to: "devise/sessions#destroy", as: :destroy_user_session
  end
end
