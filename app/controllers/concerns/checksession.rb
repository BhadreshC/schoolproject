module Checksession
	def check_session
		if current_principle
		else
			redirect_to  root_url, notice: 'login is required.'
		end
	end
end
