Rails.application.routes.draw do
  resources :indicators, only: %i(index)
  namespace :api, format: "json" do
    resources :indicators, only: %i(index)
  end
end
