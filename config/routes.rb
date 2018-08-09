Rails.application.routes.draw do

  resources :friendships, only: [:create, :update, :destroy]
  devise_for :users
  root to: 'static_pages#index'  
end
