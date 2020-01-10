class SessionsController < ApplicationController
	before_action :check_session_for_new_loign,  only: [:new]
	def new
	end

	def create
		principle = Principle.find_by_username(params[:username])
		if principle && principle.authenticate(params[:password])
			session[:principle_id] = principle.id
			redirect_to school_index_url
		else
			render :new
		end
	end

	def destroy
		session[:principle_id] = nil
		redirect_to root_url, notice: 'Logged out!'
	end
	
	private
		def check_session_for_new_loign
			if session[:principle_id]
				redirect_to school_index_url, notice: 'You are Already Login'
			else
			end
		end
end
