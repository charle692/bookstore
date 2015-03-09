Rails.application.routes.draw do
  get 'login'   => 'sessions#new'
  post 'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  get 'help'    => 'static_pages#help'

  # Creates a REST resource for books
  resources :books
  root 'static_pages#home'
end
