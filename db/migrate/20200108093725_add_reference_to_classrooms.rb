class AddReferenceToClassrooms < ActiveRecord::Migration[6.0]
  def change
  	add_reference :schools, :classroom, foreign_key: true
  end
end
