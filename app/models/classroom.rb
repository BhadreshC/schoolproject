class Classroom < ApplicationRecord
	require 'csv'
	has_many :students, before_add: :validate_student_limit
	has_one :school
	validates :C_Name, presence: true, uniqueness: true
	validates :wichstandard, length: {minimum: 1, maximum: 12}, allow_blank: false, presence: true
	
	NUMBER_OF_PERMITTED_STUDENTS = 5

	def to_csv
		CSV.generate do |csv|
			csv << ["Name", "Email", "created_at", "updated_at"]
			self.students.each do |student|
				column = [student.name, student.email, student.created_at, student.updated_at]
				csv << column
			end
			# all.each do |classroom|
			# 	if classroom.students.any?
			# 		column = [classroom.C_Name, classroom.wichstandard, classroom.created_at, classroom.updated_at]
			# 		# stdnames = classroom.students.collect { |o| o.name }.join(", ")
			# 		# emails = classroom.students.collect { |o| o.email }.join(", ")
			# 		# column << stdnames
			# 		# column << emails
			# 		csv << column
			# 	else
			# 		csv << [classroom.C_Name, classroom.wichstandard, classroom.created_at, classroom.updated_at]
			# 	end
			# end
		end
	end

	def validate_student_limit(student)
		raise Exception.new if students.size >= NUMBER_OF_PERMITTED_STUDENTS
	end
end
