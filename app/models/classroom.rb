class Classroom < ApplicationRecord
	require 'csv'
	has_many :students
	has_many :teachers
	belongs_to :school
	validates :C_Name, presence: true, uniqueness: true
	validates :wichstandard, length: {minimum: 1, maximum: 12}, allow_blank: false, presence: true
	def self.to_csv
		CSV.generate do |csv|
			csv << ["C_Name", "wichstandard", "created_at", "updated_at", "students_Of_class", "EmailAddress of student"]
			all.each do |classroom|
				if classroom.students.any?
					column = [classroom.C_Name, classroom.wichstandard, classroom.created_at, classroom.updated_at]
					stdnames = classroom.students.collect { |o| o.name }.join(", ")
					emails = classroom.students.collect { |o| o.email }.join(", ")
					column << stdnames
					column << emails
					csv << column
				else
					csv << [classroom.C_Name, classroom.wichstandard, classroom.created_at, classroom.updated_at]
				end
			end
		end
	end

end
