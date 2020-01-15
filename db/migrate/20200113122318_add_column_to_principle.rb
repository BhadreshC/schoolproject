class AddColumnToPrinciple < ActiveRecord::Migration[6.0]
	def change
			add_column :principles, :status, :boolean, default: false
	end
end
