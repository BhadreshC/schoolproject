Rails.application.routes.draw do
  get 'pages/home'
  devise_for :principles
	#resources :sessions, only: [:new, :create, :destroy]
	#post "/deactivate", to: "principles#deactivate"
	# get 'signup', to: 'principles#new', as: 'signup'
	# get 'login', to: 'sessions#new', as: 'login'
	# get 'logout', to: 'sessions#destroy', as: 'logout'
	root 'pages#home'
	resources :school do
		resources :classrooms
		resources :students
		resources :teachers
		#resources :principles
	end
	match '*a', :to => 'errors#routing', via: :get
end
