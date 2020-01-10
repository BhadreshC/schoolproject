class School < ApplicationRecord
	has_many :principles, dependent: :destroy
	has_many :classrooms, dependent: :destroy
	has_many :teachers
end
