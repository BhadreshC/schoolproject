require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module Schoolproject
	class Application < Rails::Application
		config.load_defaults 6.0
		config.exceptions_app = self.routes
		config.active_record.default_timezone = :local
	 config.time_zone = 'New Delhi'
	end
end
