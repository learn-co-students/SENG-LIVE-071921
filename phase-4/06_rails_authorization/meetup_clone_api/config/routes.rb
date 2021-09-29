Rails.application.routes.draw do
  resources :events, only: [:index, :show, :create, :update, :destroy]
  resources :groups, only: [:index, :show, :create]
  resources :user_groups, only: [:index, :create, :destroy]
  resources :user_events, only: [:index, :create, :update, :destroy]
  # resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/me", to: "users#show"
  post "/signup", to: "users#create"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
end
