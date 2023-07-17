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
  
  
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: "users/passwords" 
  }

  resources :banks 
  resources :accounts 
  resources :transactions

  root to: 'users#index'
  

  resources :users do 
    member do
      post :create_account_request
    end
  end

      
end
