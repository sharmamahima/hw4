Rails.application.routes.draw do
  # Define the root route
  root 'places#index'

  # Route definitions
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy', as: 'logout'

  # Resource routes
  resources :entries
  resources :places
  resources :sessions
  resources :users
end
