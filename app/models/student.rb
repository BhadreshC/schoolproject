class Student < ApplicationRecord
	has_and_belongs_to_many :teachers,dependent: :destroy
	belongs_to :classroom, optional: true
	validates :name, presence: true
	validates :standard, length: {minimum: 1, maximum: 12}, allow_blank: false
	validates :email, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
	validate :check_student_limit

	def check_student_limit
		if Student.where(classroom_id: self.classroom_id).count > 4
			self.errors.add(:name, "Over limit of student in classroom")
		end
	end
end
