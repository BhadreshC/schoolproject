class AddLimitsToClassroom < ActiveRecord::Migration[6.0]
	def change
		add_column :classrooms, :studentlimit, :integer
	end
end
