class Teacher < ApplicationRecord
	require 'csv'
	#----------------------try------------------
	 has_and_belongs_to_many :students
	#----------------------try------------------

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