class Principle < ApplicationRecord
	devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable
	belongs_to :school
	validates_uniqueness_of :username
	validates :email, presence: true, uniqueness: {scope: :school_id }, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

	def default_values
		self.status = false
	end

	def active_for_authentication? 
		super && status? 
	end

	def after_confirmation
		Principle.update_all status: false
		self.update_attribute(:status, true)
	end
end
