class PageController < ApplicationController
	def index
		@principle = Principle.new
	end
end
