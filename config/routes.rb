Rails.application.routes.draw do
  get 'banks/index'
  get 'banks/new'
  get 'banks/show'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  resources :banks
  root to: 'banks#index'
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
