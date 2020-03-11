class Teacher < ApplicationRecord
	has_many :activities, as: :activeable, dependent: :destroy
	belongs_to :classroom, optional: true
	has_many :students, through: :classroom
	validates :name, presence: true
	validates :MobileNo, presence:true,uniqueness: {scope: :classroom_id }, length: {minimum: 10, maximum: 10, too_short:'should be 10 digits ', too_long: 'should be 10 digits '}
	validates :qualification, presence:true
	validates :classroom_id, presence: true
	validates :gender, presence: true
	validates :email, presence: true, uniqueness: {scope: :classroom_id }, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

	#create activity based on update teacher detail
	def changed_attributes(change_val, teacher)
		@change_attribut= change_val.keys
		@change_attribut.each do |key|
			if key == "classroom_id"
				@oldclassrrom= Classroom.find_by(id: change_val[key][0])
				@newclassroom= Classroom.find_by(id: change_val[key][1])
				Activity.create_activity("update  Classroom from #{@oldclassrrom.C_Name} to #{@newclassroom.C_Name}", teacher)
			else
				Activity.create_activity("update  #{key} from #{change_val[key][0]} to #{change_val[key][1]}", teacher)
			end
		end
	end
end
