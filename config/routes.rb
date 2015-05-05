Rails.application.routes.draw do
  devise_for :users
  
  root 'books#index'
  get 'help'    => 'static_pages#help'
  get 'checkout' => 'books#checkout'
  get 'search' => 'books#search'

  # Creates a REST resource for books
  resources :books
end
