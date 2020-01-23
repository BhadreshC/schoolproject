# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!
	ActionMailer::Base.smtp_settings = {
			:username => 'RandomUser',
			:password => '',
			:domain => 'yourdomain.com',
			:address => 'smtp.sendgird.net',
			:port => '587',
			:authentication => :plain,
			:enable_starttls_auto => true
		}