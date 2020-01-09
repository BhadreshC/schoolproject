class RemoveReferencesFromSchools < ActiveRecord::Migration[6.0]
  def change
  	remove_reference :schools, :classroom, foreign_key: true
  end
end
