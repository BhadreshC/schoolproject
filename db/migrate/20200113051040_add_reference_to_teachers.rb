class AddReferenceToTeachers < ActiveRecord::Migration[6.0]
	def change
		add_reference :teachers, :classroom, foreign_key: true
	end
end
