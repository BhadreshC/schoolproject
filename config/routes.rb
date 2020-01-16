Rails.application.routes.draw do
	resources :principles
	resources :sessions, only: [:new, :create, :destroy]
	post "/deactivate", to: "principles#deactivate"
	get 'signup', to: 'principles#new', as: 'signup'
	get 'login', to: 'sessions#new', as: 'login'
	get 'logout', to: 'sessions#destroy', as: 'logout'
	root 'sessions#new'
	resources :school do
		resources :classrooms
		resources :students
		resources :teachers
	end
end
