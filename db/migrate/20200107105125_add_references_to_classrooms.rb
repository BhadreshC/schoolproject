class AddReferencesToClassrooms < ActiveRecord::Migration[6.0]
	def change
		add_reference :classrooms, :teacher, foreign_key: true
		add_reference :classrooms, :student, foreign_key: true
	end
end
