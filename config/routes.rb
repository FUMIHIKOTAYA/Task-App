Rails.application.routes.draw do
  root 'users#new'
  resources :tasks do
    collection do
      post :confirm
    end
  end

  resources :labels, only: [:new, :create, :index, :destroy]

  resources :sessions, only: [:new, :create, :destroy]
  resources :users

  namespace :admin do
    resources :users
  end
end
