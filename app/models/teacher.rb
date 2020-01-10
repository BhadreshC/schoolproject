class Teacher < ApplicationRecord
	require 'csv'
	has_many :students

	def self.to_csv
		attributes = %w{id name email }
		CSV.generate(headers: true) do |csv|
			csv << attributes
			all.each do |teacher|
				csv << attributes.map{ |attr| teacher.send(attr) }
			end
		end
	end
end
