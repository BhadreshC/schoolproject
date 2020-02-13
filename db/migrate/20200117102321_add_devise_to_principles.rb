class AddDeviseToPrinciples < ActiveRecord::Migration[6.0]
	def self.up
		change_table :principles do |t|
			t.string :usersname,              null: false, default: ""
			t.string :encrypted_password, null: false, default: ""

			t.string   :reset_password_token
			t.datetime :reset_password_sent_at

			t.datetime :remember_created_at

			t.integer  :sign_in_count, default: 0, null: false
			t.datetime :current_sign_in_at
			t.datetime :last_sign_in_at
			t.string   :current_sign_in_ip
			t.string   :last_sign_in_ip

			t.string   :confirmation_token
			t.datetime :confirmed_at
			t.datetime :confirmation_sent_at
			t.string   :unconfirmed_username

			t.integer  :failed_attempts, default: 0, null: false
			t.string   :unlock_token
		end

		add_index :principles, :username, unique: true
		add_index :principles, :reset_password_token, unique: true
		add_index :principles, :confirmation_token, unique: true
		add_index :principles, :unlock_token, unique: true
	end

	def self.down

		raise ActiveRecord::IrreversibleMigration
	end
end
