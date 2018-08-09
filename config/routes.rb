Rails.application.routes.draw do

  get 'users/index'
  root to: 'static_pages#index'

  resources :likes
  resources :friendships, only: [:create, :update, :destroy]
  devise_for :users
  resources :users, only: [:index, :show]

  match 'like',to: 'likes#like', via: :post
  match 'dislike', to: 'likes#dislike', via: :delete
  
end
