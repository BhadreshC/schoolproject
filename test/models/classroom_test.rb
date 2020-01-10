require 'test_helper'

class ClassroomTest < ActiveSupport::TestCase

	test 'attempting to add more than the permitted number of users to an classroom should fail' do
		org = create(:classrooms)
		assert_raises Exception do
			org.students.push(create_list(:student, 6))
		end
		assert_equal 5, org.students.size
	end
end
