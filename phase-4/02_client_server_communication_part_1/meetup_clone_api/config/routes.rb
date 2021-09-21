Rails.application.routes.draw do
  resources :events, only: [:index, :show]
  resources :groups, only: [:index, :show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
