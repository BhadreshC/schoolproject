class AddColumnToTeachers < ActiveRecord::Migration[6.0]
	def change
		add_column :teachers, :MobileNo, :string
		add_column :teachers, :qualification, :string
		add_column :teachers, :gender, :string, :default => 'Male'
	end
end
