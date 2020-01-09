class Student < ApplicationRecord
	#----------------------try------------------
	has_one :classroom
	#----------------------try------------------
	validates :name, presence: true
	validates :standard, length: {minimum: 1, maximum: 12}, allow_blank: false
	validates :email, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
end
