Rails.application.routes.draw do
  devise_for :users
  get 'help'    => 'static_pages#help'

  # Creates a REST resource for books
  resources :books
  root 'books#index'
end
