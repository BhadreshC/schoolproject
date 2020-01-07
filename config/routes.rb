Rails.application.routes.draw do
  resources :students
  resources :teachers
   resources :sessions, only: [:new, :create, :destroy]  
  get 'signup', to: 'principles#new', as: 'signup'  
  get 'login', to: 'sessions#new', as: 'login'  
  get 'logout', to: 'sessions#destroy', as: 'logout'  
  resources :principles  
  get 'school/index'  
  root 'sessions#new'
end
