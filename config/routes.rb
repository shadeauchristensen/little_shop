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
        get "/merchants/find", to: "merchants#find" #watch out for scope! issue was endpoint hit :id before it hit find. returning no data
    
        resources :merchants, only: [:index, :show, :create, :update] do
          get "/items", to: "merchants/items_merchant#index"
        end
    
        resources :items, only: [:index, :show, :create, :update] do
          get "/merchant", to: "items/merchant_items#show"
        end
    
        get "/items/find_all", to: "items#find_all"

        get "/merchants/:merchant_id/customers", to: "customers#show"
        get "/merchants/:merchant_id/invoices", to: "invoices#show"
      end
    end
  end
