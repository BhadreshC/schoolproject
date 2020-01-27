Rails.application.routes.draw do
	devise_for :principles
	match '*a', :to => 'errors#routing', via: :get
	root :to => redirect("/principles/sign_in")
	resources :school do
		post '/principles', to: 'principles#create'
		get '/principles/new', to: 'principles#new', as: 'new_principle'
		resources :classrooms
		resources :students
		resources :teachers
		end
end
