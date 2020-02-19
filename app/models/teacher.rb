class Teacher < ApplicationRecord
	has_and_belongs_to_many :students, dependent: :destroy
	belongs_to :classroom, optional: true, dependent: :destroy
	has_many :activities, as: :activeable
	validates :Mobile_No, presence:true, length: {minimum: 10, maximum: 10, too_short:'should be 10 digits ', too_long: 'should be 10 digits '}
	validates :qualification, presence:true
	validates :email, presence: true, uniqueness: {scope: :classroom_id }, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
end
