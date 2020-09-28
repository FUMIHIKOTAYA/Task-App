Rails.application.routes.draw do
  root 'tasks#index'
  resources :tasks do
    collection do
      post :confirm
    end
  end

  resources :users, only: [:new, :create, :show]
end
