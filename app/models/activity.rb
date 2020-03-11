class Activity < ApplicationRecord
	belongs_to :activeable, polymorphic: true

	#create the activity for student teacher
	def self.create_activity(message, student_detail)
		Activity.create(name: message, activeable: student_detail)
	end
end
