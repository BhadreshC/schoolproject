module Studentable
	extend ActiveSupport::Concern
	included do
		before_action :set_student, only: [:show, :edit, :update, :destroy]
		before_action :set_school
		before_action :check_session, :check_permission
	end

	def index
		@students = Student.joins(:classroom).where("classrooms.school_id = ? " , @school).order(:standard)
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
	end

	def create
		@student = Student.new(student_params)
		@tech = Teacher.where(classroom_id: params[:student][:classroom_id])
		@tech.each do |t|
			t.students << @student
		end
		@schoolclassrooms = @school.classrooms.all
		Activity.create_activity("#{@student.name} get the admission", @student)
		@schoolclassrooms = @school.classrooms.all
		respond_to do |format|
			if @student.save
				format.html { redirect_to school_student_path(@school, @student), notice: 'Student was successfully created.' }
				format.json { render :show, status: :created, location: @student }
			else
				format.html { render :new }
				format.json { render json: @student.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
		@schoolclassrooms = @school.classrooms.all
		respond_to do |format|
			if @student.update(student_params)
				if @student.saved_change_to_name?
					Activity.create_activity("update name from  #{@student.name_before_last_save} to  #{@student.name}" , @student)
				end
				if @student.saved_change_to_email?
					Activity.create_activity("update email from  #{@student.email_before_last_save} to  #{@student.email}" , @student)
				end
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
			@student = Student.find_by(id: params[:id]) or not_found
		end

		def student_params
			params.require(:student).permit(:name, :email, :classroom_id)
		end
end
