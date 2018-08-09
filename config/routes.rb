Rails.application.routes.draw do

  root to: 'static_pages#index'

  resources :likes
  resources :friendships, only: [:create, :update, :destroy]
  devise_for :users

  match 'like',to: 'likes#like', via: :post
  match 'dislike', to: 'likes#dislike', via: :delete
  
end
