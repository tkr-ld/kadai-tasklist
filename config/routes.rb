Rails.application.routes.draw do
  
  get 'toppages/index'

  get 'sessions/new'

  get 'sessions/create'

  get 'sessions/delete'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  root to: 'toppages#index'
  
  get 'signup' , to: 'users#new'
  resources :users, only: [:index, :show, :new, :create]
  
  resources :tasks, only: [:new, :create, :edit, :update, :destroy]
end