class Principle < ApplicationRecord
	belongs_to :school
	has_secure_password
	validates :username, presence: true
	validates_uniqueness_of :username
	validates :email, presence: true, uniqueness: {scope: :school_id }, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
	before_create :default_values
	def default_values
		self.status = true
	end
end