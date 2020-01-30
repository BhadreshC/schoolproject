class ChangeColumnToClassrooms < ActiveRecord::Migration[6.0]
	def change
		rename_column :classrooms, :wichstandard, :standard
	end
end
