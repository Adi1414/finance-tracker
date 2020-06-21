Rails.application.routes.draw do
  resources :user_stocks, only: [:create, :destroy]
  resources :friendships, only: [:create, :destroy]
  get '/my_portfolio', to: 'user#my_portfolio'
  get 'my_friends', to: 'user#my_friends'
  get 'search_stock', to: 'stocks#search'
  get 'search_friends', to: 'user#search_friends'
  resources :user, only: [:show]
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "welcome#index"
  
end
