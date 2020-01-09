class School < ApplicationRecord
	has_many :principles, dependent: :destroy
	#----------------------try------------------
	has_many :classrooms, dependent: :destroy
	#----------------------try------------------
end
