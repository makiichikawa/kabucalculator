Rails.application.routes.draw do
  root to: "welcome#index"
  resources :indicators, only: %i(index show)
  namespace :api, format: "json" do
    resources :indicators, only: %i(index)
  end
  get 'additionals', to: 'indicators#additionals'
  get 'tos', to: 'welcome#tos'
end
