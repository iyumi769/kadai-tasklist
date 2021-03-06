Rails.application.routes.draw do
  get 'sessions/new'

  get 'sessions/create'

  get 'sessions/destroy'

  get 'users/new'

  get 'users/create'

  get 'toppages/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #root to: 'tasks#index'
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  
  resources :tasks
  #, only: [:create, :destroy, :show, :edit, :new, :index, :update]
  
#  get 'new_task', to: 'tasks#new'
  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :new, :create]
end
