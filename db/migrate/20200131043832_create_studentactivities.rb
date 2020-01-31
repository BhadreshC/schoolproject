class CreateStudentactivities < ActiveRecord::Migration[6.0]
	def change
		create_table :studentactivities do |t|
			t.string :activity_detail
			t.belongs_to :student, index: true
			t.datetime :created_at
		end
	end
end
