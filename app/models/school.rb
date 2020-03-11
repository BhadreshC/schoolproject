class School < ApplicationRecord
	has_many :principles, dependent: :destroy
	has_many :classrooms
	validates :name, presence:true
end
