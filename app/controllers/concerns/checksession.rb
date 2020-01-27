module Checksession
	def check_session
		if current_principle
		else
			redirect_to  root_url, notice: 'login is required.'
		end
	end

	def check_permission
		begin
			@principles = @school.principles
			rescue ActiveRecord::RecordNotFound
				redirect_to :controller => "classroom", :action => "index"
			return
		end

		if @principles.exists?(current_principle.id) or not_found
		end
	end
end
