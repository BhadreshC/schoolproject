class Student < ApplicationRecord
	has_many :activities, as: :activeable, dependent: :destroy
	belongs_to :classroom, optional: true
	has_many :teachers, through: :classroom
	validates :name, presence: true
	validates :email, uniqueness: {scope: :classroom_id }, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
	validates :classroom_id, presence: true
	validate :check_student_limit, on: :create

	# set limit for number of students in classroom
	def check_student_limit
		@classroom = Classroom.where(id: self.classroom_id).first
		if Student.where(classroom_id: self.classroom_id).count >= @classroom.studentlimit
			self.errors.add(:base, "Oppss!!! classroom is full")
		end
	end

	# create the activity based on edit students details
	def changed_attributes(update_value, student)
		@change_attribute= update_value.keys
		@change_attribute.each do |key|
			Activity.create_activity("update  #{key} from #{update_value[key][0]} to #{update_value[key][1]}", student)
		end
	end
end
