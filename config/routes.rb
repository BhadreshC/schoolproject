Rails.application.routes.draw do
	devise_for :principles, path: '', path_names:{
		sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'cmon_let_me_in' 
	}
	root :to => redirect("/login")
	resources :school do
		post '/principles', to: 'principles#create'
		get '/principles/new', to: 'principles#new', as: 'new_principle'
		resources :classrooms do
			member do
				get :upgradeclass
				post :upgradeclass
				post :updateclass
			end
		end
		resources :students
		resources :teachers
	end
	match '*a', :to => 'errors#routing', via: :get
end
