Rails.application.routes.draw do
  get 'sessions/new'

  root 'items#index'
  resources :items
  resources :categories, only: [:show]
  resources :cart_items, only: [:create, :index, :update, :destroy]
  resources :users

  namespace :user do
    resources :orders, only: [:index, :show]
  end
  resources :orders, only: [:create]

  # resource  :checkout,   only: [:create, :update]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  post 'cart_items/increase', to: 'cart_items#increase'
  post 'cart_items/decrease', to: 'cart_items#decrease'

  get "cart_item/confirmation", to: "cart_items#confirmation"
  get "order/payment", to: "orders#payment"


end
