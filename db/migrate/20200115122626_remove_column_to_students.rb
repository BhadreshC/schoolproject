class RemoveColumnToStudents < ActiveRecord::Migration[6.0]
	def change
		remove_column :students, :standard
	end
end
