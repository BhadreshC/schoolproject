class School < ApplicationRecord
	has_many :principles, dependent: :destroy   #success
	#----------------------try------------------
	has_many :classrooms
	#----------------------try------------------
end
