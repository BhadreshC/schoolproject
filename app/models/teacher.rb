class Teacher < ApplicationRecord
	require 'csv'
	has_many :student

	def self.to_csv
		attributes = %w{id name email }
		CSV.generate(headers: true) do |csv|
			csv << attributes
			all.each do |teacher|
				csv << attributes.map{ |attr| teacher.send(attr) }
			end
		end
	end
	validates :Mobile_No, presence:true, length: {minimum: 14, maximum: 15}
	validates :name, presence:true
	validates :qualification, presence:true
	validates :email, presence: true, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

end
