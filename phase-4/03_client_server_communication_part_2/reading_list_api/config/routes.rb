Rails.application.routes.draw do
  resources :books, only: [:index, :show, :create]
  resources :user_books, only: [:create, :update, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
