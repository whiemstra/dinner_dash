Rails.application.routes.draw do
  get 'sessions/new'

  root 'items#index'
  resources :items#, only: [:index, :show]
  resources :categories, only: [:show]
  resources :cart_items, only: [:create, :index, :update, :destroy]
  resources :users

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  post 'cart_items/increase', to: 'cart_items#increase'
  post 'cart_items/decrease', to: 'cart_items#decrease'


  namespace :admin do
    get '/', to: 'dashboard#index'
    resources :items
    resources :categories
    #resources :orders
  end

end
