class Student < ApplicationRecord
	#----------------------try------------------
	 has_and_belongs_to_many :teachers
	#----------------------try------------------
end
