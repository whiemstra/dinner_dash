Rails.application.routes.draw do
  root 'items#index'
  resources :items
  resources :categories, only: [:show]
  resources :cart_items, only: [:create]
end
