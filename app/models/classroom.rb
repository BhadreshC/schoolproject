class Classroom < ApplicationRecord
	require 'csv'
	#----------------------try------------------
	has_many :students
	has_one :school
	#----------------------try------------------
end
