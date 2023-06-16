Rails.application.routes.draw do
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show]
  end
  root "users#index" # Set the root path to the users index action

  # Add more routes as needed
end
