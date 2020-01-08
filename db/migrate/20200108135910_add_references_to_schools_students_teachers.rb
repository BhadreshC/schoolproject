class AddReferencesToSchoolsStudentsTeachers < ActiveRecord::Migration[6.0]
	def change
		add_reference :classrooms, :school, foreign_key: true
		add_reference :students, :classroom, foreign_key: true
		add_reference :teachers, :student, foreign_key: true
	end
end
