Rails.application.routes.draw do
  devise_for :users # Add this line to include Devise routes

  resources :users, only: [:index, :show, :edit, :update] do
    resources :posts, only: [:index, :show, :new, :create, :destroy] do
      resources :comments, only: [:create, :destroy]
      resources :likes, only: [:create]
    end
  end
# API routes
namespace :api do
  resources :users, only: [] do
    resources :posts, only: [:index]
  end
end

    resources :users, only: [] do
      resources :posts, only: [] do
        resources :comments, only: [:index] # API endpoint to list all comments for a user's post
        resources :comments, only: [:create] # API endpoint to add a comment to a post
      end
    end

  root "users#index" # Set the root path to the users index action

  # Add more routes as needed
end
