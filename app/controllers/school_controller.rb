class SchoolController < ApplicationController
	def index
		@principles = Principle.order("created_at").all
		# Post.order("created_at").last
	end
end
