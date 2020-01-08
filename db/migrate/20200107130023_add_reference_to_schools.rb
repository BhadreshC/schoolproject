class AddReferenceToSchools < ActiveRecord::Migration[6.0]
  def change
  	add_reference :teachers, :school, foreign_key: true
  end
end
