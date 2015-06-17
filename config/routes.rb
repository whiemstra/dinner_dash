Rails.application.routes.draw do
  root 'categories#index'
  resources :items
  resources :categories
end
