Rails.application.routes.draw do
	# resources :school
	resources :principles

	#resources :principles
	# resources :classrooms
	#resources :students
	#resources :teachers
	resources :sessions, only: [:new, :create, :destroy]
	get 'signup', to: 'principles#new', as: 'signup'
	get 'login', to: 'sessions#new', as: 'login'
	get 'logout', to: 'sessions#destroy', as: 'logout'
	get 'school/index'
	root 'sessions#new'

	resources :school do
		resources :classrooms
		resources :students
		resources :teachers


	end
end
