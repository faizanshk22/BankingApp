Rails.application.routes.draw do
  authenticated :user, ->(user) { user.admin? } do
    root to: 'admins#index', as: :authenticated_admin_root
  end
  get 'admins/index', as: 'admins_index'
  
  resources :admins do 
    member do
      post :approve_account
      post :decline_account
    end
  end
  get '/pending', to: 'admins#pending'
  
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: "users/passwords" 
  }

  resources :banks 
  resources :accounts 
  resources :transactions 

  root to: 'users#index'
  get '/get_users_by_bank', to: 'transactions#get_users_by_bank'


  resources :users do 
    member do
      post :create_account_request
      get :approve
      get :decline
    end
  end

      
end
