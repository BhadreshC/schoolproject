class AddToReferencesTo < ActiveRecord::Migration[6.0]
  def change
  	add_reference :principles, :school, foreign_key: true
  end
end
