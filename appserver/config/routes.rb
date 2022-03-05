Rails.application.routes.draw do
  root to: "home#index"
  resources :indicators, only: %i(index)
  namespace :api, format: "json" do
    resources :indicators, only: %i(index)
  end
end
