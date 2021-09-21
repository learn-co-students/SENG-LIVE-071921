Rails.application.routes.draw do
  resources :events, only: [:index, :show, :create]
  resources :groups, only: [:index, :show, :create]
  resources :user_groups, only: [:create]
  resources :user_events, only: [:create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
