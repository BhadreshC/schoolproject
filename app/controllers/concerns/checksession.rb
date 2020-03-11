module Checksession
	#check principles session for login
	def check_session
		# if current_principle
		# else
		# 	redirect_to  root_url, notice: 'login is required.'
		# end
	end

	#check permission for direct access of other school
	def check_permission
		# @principles = @school.principles.find_by(id: current_principle.id)
		# not_found if @principles.blank?
	end
end

