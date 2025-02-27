# Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.

  Rails.application.routes.draw do

  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show]
        get "/merchants/:merchant_id/items", to: "merchants/items_merchant#index"


  get "/merchants", to: "merchants#index"
  get "/merchants/:id", to: "merchants#show"
  post "/merchants", to: "merchants#create"
  patch "/merchants/:id", to: "merchants#update"

  get "/items", to: "items#index"
  get "/items/:id", to: "items#show"
  post "/items", to: "items#create"
  patch "/items/:id", to: "items#update"

      resources :items, only: [:index, :show]
      get "/items/:item_id/merchant", to: "items/merchant_items#show"
    end
  end
end
