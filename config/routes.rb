Rails.application.routes.draw do

  get 'admins/index'
  
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :banks do
    resources :accounts 
  end 

  
  
  
  

  root to: 'banks#index'
  

    resources :users 
      
end
