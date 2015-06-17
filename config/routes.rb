Rails.application.routes.draw do
  root 'items#index'
  resources :items
  resources :categories, only: [:show]
end
