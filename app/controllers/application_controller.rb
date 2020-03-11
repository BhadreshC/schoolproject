class ApplicationController < ActionController::Base
	rescue_from ActionController::RoutingError, :with => :render_404
	rescue_from ActiveRecord::RecordNotFound, with: :render_404
	before_action :configure_permitted_parameters, if: :devise_controller?
	protect_from_forgery with: :exception

	protected

		#check params of principles
		def configure_permitted_parameters
			devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation)}
			devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password)}
		end

		#redirect principle after login
		def after_sign_in_path_for(resource)
			if resource.status == true
				@school= current_principle.school
				stored_location_for(resource) || school_path(@school)
			else
				@school= current_principle.school
				stored_location_for(resource) || school_path(@school)
			end
		end

	private

		#page not found
		def render_404(exception = nil)
			if exception
				logger.info "Rendering 404: #{exception.message}"
			end
			render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
		end

		#records not found
		def not_found
			raise ActionController::RoutingError.new('Not Found')
		end
end
 