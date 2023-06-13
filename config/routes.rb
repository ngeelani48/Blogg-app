Rails.application.routes.draw do
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show]
  end
  # Add more routes as needed

  # root "controller#action" - Uncomment and modify this line to define the root path route
end
