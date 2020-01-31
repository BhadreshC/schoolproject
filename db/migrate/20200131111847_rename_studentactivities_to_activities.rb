class RenameStudentactivitiesToActivities < ActiveRecord::Migration[6.0]
	def change
		rename_table :studentactivities, :activities
	end
end
