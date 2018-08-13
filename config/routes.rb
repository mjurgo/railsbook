Rails.application.routes.draw do

  root to: 'static_pages#index'

  resources :posts, only: [:show, :index, :new, :create]
  resources :likes
  resources :friendships, only: [:create, :update, :destroy]
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }
  resources :users, only: [:index, :show]

  match 'like',to: 'likes#like', via: :post
  match 'dislike', to: 'likes#dislike', via: :delete
  
end
