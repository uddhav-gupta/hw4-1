Rails.application.routes.draw do
  root to: "places#index"
  
  get "/login", to: "sessions#new"
  post "/sessions", to: "sessions#create"
  get "/logout", to: "sessions#destroy"
  
  get "/signup", to: "users#new"
  resources :users, only: [:create]
  
  resources :places do
    resources :entries, only: [:new, :create]
  end
end