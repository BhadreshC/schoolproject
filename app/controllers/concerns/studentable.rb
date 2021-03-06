module Studentable
	extend ActiveSupport::Concern
	included do
		before_action :set_school
		before_action :set_student, only: [:show, :edit,:update,:destroy]
		before_action :check_session, :check_permission
	end

	def index
		@students = Student.includes(:classroom).where("classrooms.school_id = ? " , @school).references(:classroom)
		@schoolclass = @school.classrooms
	end

	def show
		@studentclassroom = @student.classroom
		@stud_activities = Activity.where(activeable_id: params[:id], activeable_type: "Student")
	end

	def new
		@student = Student.new
		@schoolclassrooms = @school.classrooms.all
	end

	def edit
		@schoolclassrooms = @school.classrooms.all
		@editclass_disabled = "edit disable for classroom"
	end

	def create
		@student = Student.new(student_params)
		@schoolclassrooms = @school.classrooms.all
		respond_to do |format|
			if @student.save
				Activity.create_activity("#{@student.name} get the admission", @student)
				format.html { redirect_to school_student_path(@school, @student), notice: 'Student was successfully created.' }
				format.json { render :show, status: :created, location: @student }
			else
				format.html { render :new }
				format.json { render json: @student.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
		params[:student].delete :classroom_id
		@schoolclassrooms = @school.classrooms.all
		@student.attributes = student_params
		update_value = @student.changes
		respond_to do |format|
			if @student.save
				@student.changed_attributes(update_value, @student)
				format.html { redirect_to school_student_path(@school, @student), notice: 'Student was successfully updated.' }
				format.json { render :show, status: :ok, location: @student }
			else
				format.html { render :edit }
				format.json { render json: @student.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@student.destroy
		respond_to do |format|
			format.html { redirect_to school_students_url, notice: 'Student was successfully destroyed.' }
			format.json { head :no_content }
		end
	end

	private
		def set_school
			@school = School.find_by(id: params[:school_id]) or not_found
		end

		def set_student
			@student = Student.joins(:classroom).where("classrooms.school_id = ? AND students.id = ?", @school.id, params[:id]).first or not_found
		end

		def student_params
			params.require(:student).permit(:name, :email, :classroom_id)
		end
end
