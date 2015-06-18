Rails.application.routes.draw do
  root 'items#index'
  resources :items
  resources :categories, only: [:show]
  resources :cart_items, only: [:create, :index, :update, :destroy]
  resources :users

  get '/login', to: 'sessions#new'
  #post '/login', to: 'sessions#create'
  #delete '/logout', to: 'sessions#destroy'

end
