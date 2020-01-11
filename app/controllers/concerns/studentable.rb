module Studentable
	extend ActiveSupport::Concern
	included do
		before_action :check_session
		before_action :set_student, only: [:show, :edit, :update, :destroy]
		before_action :set_school

	end

	def index
		@students = Student.includes(:classroom)

	end

	def show
		@studentclassroom = @student.classroom
	end

	def new
		@student = Student.new
	end

	def edit
	end

	def create
		@student = Student.new(student_params)

		respond_to do |format|
			if @student.save
				format.html { redirect_to @student, notice: 'Student was successfully created.' }
				format.json { render :show, status: :created, location: @student }
			else
				format.html { render :new }
				format.json { render json: @student.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
		respond_to do |format|
			if @student.update(student_params)
				format.html { redirect_to @student, notice: 'Student was successfully updated.' }
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
			format.html { redirect_to students_url, notice: 'Student was successfully destroyed.' }
			format.json { head :no_content }
		end
	end

	private
		def set_school
				@school = School.find_by(id: params[:school_id])
		end
		def set_student
			@student = Student.find(params[:id])
		end

		def student_params
			params.require(:student).permit(:name, :email, :standard, :classroom_id)
		end
end