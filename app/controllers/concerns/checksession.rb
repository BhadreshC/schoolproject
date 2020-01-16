module Checksession
	def check_session
		if session[:principle_id]
		else
			redirect_to  root_url, notice: 'login is required.'
		end
	end
	def check_session_for_principle
		if session[:principle_id]
			redirect_to  root_url, notice: 'login is required.'
		else
		end
	end
	def check_for_direct_access
			@schoolid= params[:id]
			@school=School.find_by(id: @schoolid)
			puts "_----------------------------------"
			@sp= @school.principles
			puts @sp.as_json
			if @sp.exists?(session[:principle_id])
			else
				redirect_to  root_url, notice: 'login is required.'
			end
	end
end
