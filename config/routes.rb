Rails.application.routes.draw do
  devise_for :users
  get 'help'    => 'static_pages#help'

  # Creates a REST resource for books
  resources :books
  get 'search' => 'books#search'
  root 'books#index'
  get 'checkout' => 'books#checkout'
end
