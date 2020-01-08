class CreateClassrooms < ActiveRecord::Migration[6.0]
  def change
    create_table :classrooms do |t|
      t.string :C_Name
      t.integer :wichstandard

      t.timestamps
    end
  end
end
