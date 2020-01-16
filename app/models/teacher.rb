class Teacher < ApplicationRecord
	require 'csv'
	belongs_to :classroom, optional: true
	has_and_belongs_to_many :students, dependent: :destroy

	def self.to_csv
		attributes = %w{id name email }
		CSV.generate(headers: true) do |csv|
			csv << attributes
			all.each do |teacher|
				csv << attributes.map{ |attr| teacher.send(attr) }
			end
		end
	end
	validates :Mobile_No, presence:true, length: {minimum: 10, maximum: 10, too_short:'should be 10 digits ', too_long: 'should be 10 digits '}
	validates :qualification, presence:true
	validates :email, presence: true, uniqueness: {scope: :classroom_id }, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
end
