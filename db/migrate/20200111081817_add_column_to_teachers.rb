class AddColumnToTeachers < ActiveRecord::Migration[6.0]
	def change
		add_column :teachers, :Mobile_No, :string
		add_column :teachers, :qualification, :string
		add_column :teachers, :gender, :string, :default => 'Male'
	end
end
