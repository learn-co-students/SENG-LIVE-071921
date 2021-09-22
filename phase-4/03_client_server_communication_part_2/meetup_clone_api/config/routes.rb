Rails.application.routes.draw do
  resources :events
  resources :groups, only: [:index, :show, :create]
  resources :user_groups, only: [:create, :destroy]
  resources :user_events, only: [:create, :update, :destroy]
  # resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
