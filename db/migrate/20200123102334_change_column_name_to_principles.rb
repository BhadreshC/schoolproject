class ChangeColumnNameToPrinciples < ActiveRecord::Migration[6.0]
	def change
		rename_column :principles, :unconfirmed_username, :unconfirmed_email
	end
end
