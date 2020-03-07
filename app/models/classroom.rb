class Classroom < ApplicationRecord
	require 'csv'
	has_many :students, dependent: :destroy
	has_many :teachers, dependent: :destroy
	belongs_to :school
	validates :C_Name, presence: true, uniqueness: {scope: :school_id }
	validates :standard, length: {minimum: 1, maximum: 12}, allow_blank: false, presence: true
	def to_csv
		CSV.generate do |csv|
			csv << ["name", "email", "standard", "created_at","updated_at"]
			self.students.all.each do |student|
				csv << [student.name, student.email,student.classroom.standard,student.created_at,student.updated_at]
			end
		end
	end
end
