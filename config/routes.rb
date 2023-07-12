Rails.application.routes.draw do
  get 'admins/dashboard'
  get 'admins/index'
  get 'banks/index'
  get 'banks/new'
  get 'banks/show'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :banks
  root to: 'banks#index'
  
  namespace :admin do 
    #get 'dashboard', to: 'dashboard#index'
    resources :users
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
