class ApplicationController < ActionController::Base
	rescue_from ActionController::RoutingError, :with => :render_404
	protect_from_forgery with: :exception

	private
		def current_principle
			Principle.where(id: session[:principle_id]).first
		end
		helper_method :current_principle

		def render_404(exception = nil)
			if exception
				logger.info "Rendering 404: #{exception.message}"
			end
		render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
		end
		def not_found
			raise ActionController::RoutingError.new('Not Found')
		end
end
