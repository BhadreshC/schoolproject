class Classroom < ApplicationRecord
	require 'csv'
	has_many :students, dependent: :destroy
	has_many :teachers, dependent: :destroy
	belongs_to :school
	validates :C_Name, presence: true, uniqueness: {scope: :school_id }
	validates :standard, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 12 }
	validates :studentlimit, presence: true

	#for download csv file for particular classroom
	def to_csv
		CSV.generate do |csv|
			csv << ["CLASSROOM DETAILS"]
			csv << ["classroom", "standard","limit of student", "available students","remaining students"]
			@classroom= Classroom.find(id)
			csv << [@classroom.C_Name, @classroom.standard,@classroom.studentlimit, @classroom.students.count, @classroom.studentlimit-@classroom.students.count]
			csv << ["STUDENTS DETAILS"]
			csv << ["name", "email", "standard", "created_at","updated_at"]
			self.students.all.each do |student|
				csv << [student.name, student.email,student.classroom.standard,student.created_at,student.updated_at]
			end
			csv << ["TEACHER DETAILS"]
			csv << ["name", "email", "mobile No", "qualification", "gender", "created_at","updated_at"]
			self.teachers.all.each do |teacher|
				csv << [teacher.name, teacher.email, teacher.MobileNo, teacher.qualification, teacher.gender, teacher.created_at, teacher.updated_at]
			end
		end
	end
end
