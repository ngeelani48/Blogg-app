Rails.application.routes.draw do
  devise_for :users # Add this line to include Devise routes

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create] do
      resources :comments, only: [:create]
      resources :likes, only: [:create]
    end
  end

  root "users#index" # Set the root path to the users index action

  # Add more routes as needed
end
