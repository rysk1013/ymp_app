Rails.application.routes.draw do
  root to: 'posts#index'
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :users, only: [:show]
  resources :posts do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end
  resources :tags, except: [:index, :new, :create, :edit, :update, :destroy, :show] do
    get 'posts', to: 'posts#search'
  end
end