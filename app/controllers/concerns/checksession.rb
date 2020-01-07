module Checksession
	def check_session
		if session[:principle_id]
		else
			redirect_to  root_url, notice: 'login is required.'
		end
	end
end
