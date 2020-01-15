class ChangeColumnNameToSchool < ActiveRecord::Migration[6.0]
	def change
		rename_column :schools, :princile, :principle
	end
end
