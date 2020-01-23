class RemoveColumnToPrinciples < ActiveRecord::Migration[6.0]
	def change
		remove_column :principles, :sign_in_count, :integer
		remove_column :principles, :current_sign_in_at, :datetime
		remove_column :principles, :last_sign_in_at, :datetime
		remove_column :principles, :current_sign_in_ip, :string
		remove_column :principles, :last_sign_in_ip, :string
		remove_column :principles, :password_digest, :string

	end
end
