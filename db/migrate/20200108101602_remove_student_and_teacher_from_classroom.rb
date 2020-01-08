class RemoveStudentAndTeacherFromClassroom < ActiveRecord::Migration[6.0]
  def change
  	remove_reference :classrooms, :teacher, foreign_key: true
  	remove_reference :classrooms, :student, foreign_key: true
  	remove_reference :teachers, :school, foreign_key: true
  end
end
