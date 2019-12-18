Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'posts#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  resources :users
  resources :posts do
    resources :comments, only: [:create, :destroy]
  end
  resources :talks, only: [:show, :create, :destroy]
  resources :notifications, only: :index
end
