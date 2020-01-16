class Student < ApplicationRecord
	has_and_belongs_to_many :teachers,dependent: :destroy
	belongs_to :classroom, optional: true
	validates :name, presence: true
	validates :email, uniqueness: {scope: :classroom_id }, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
	validate :check_student_limit
	def check_student_limit
		if Student.where(classroom_id: self.classroom_id).count > 4
			self.errors.add(:name, "Over limit of student in classroom")
		end
	end
end
