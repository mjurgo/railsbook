Rails.application.routes.draw do

  # root to: 'static_pages#index'
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }

  devise_scope :user do
    authenticated :user do
      root 'posts#index', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end


  resources :posts, only: [:show, :index, :new, :create] do
    resources :comments, module: :posts
  end
  # resources :likes
  resources :friendships, only: [:create, :update, :destroy]  
  resources :users, only: [:index, :show]

  match 'like',to: 'likes#like', via: :post
  match 'dislike', to: 'likes#dislike', via: :delete
  
end
