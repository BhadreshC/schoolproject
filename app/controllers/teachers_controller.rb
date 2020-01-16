class TeachersController < ApplicationController
	include Checksession
	before_action :set_teacher, only: [:show, :edit, :update, :destroy]
	before_action :set_school
	before_action :check_session

	def index
		@teachers = Teacher.joins(:classroom).where("classrooms.school_id = ? " , @school)
		@schoolclass = @school.classrooms
		respond_to do |format|
			format.html
			format.csv { send_data @teachers.to_csv, filename: "teachers-#{Date.today}.csv" }
		end
	end

	def show; end

	def new
		@teacher = Teacher.new
		@schoolclassrooms = @school.classrooms.all
	end

	def edit
		@schoolclassrooms = @school.classrooms.all
	end

	def create
		@schoolclassrooms = @school.classrooms.all
		@teacher = Teacher.new(teacher_params)
		respond_to do |format|
			if @teacher.save
				format.html { redirect_to school_teacher_path(@school, @teacher), notice: 'Teacher was successfully created.' }
				format.json { render :show, status: :created, location: @teacher }
			else
				format.html { render :new }
				format.json { render json: @teacher.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
		@schoolclassrooms = @school.classrooms.all
		respond_to do |format|
		if @teacher.update(teacher_params)
			format.html { redirect_to school_teacher_path(@school, @teacher), notice: 'Teacher was successfully updated.' }
			format.json { render :show, status: :ok, location: @teacher }
		else
			format.html { render :edit }
			format.json { render json: @teacher.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@teacher.destroy
		respond_to do |format|
			format.html { redirect_to school_teachers_url, notice: 'Teacher was successfully destroyed.' }
			format.json { head :no_content }
		end
	end

	private
		def set_school
			@school = School.find_by(id: params[:school_id])
		end

		def set_teacher
			@teacher = Teacher.find_by(id: params[:id])
		end

		def teacher_params
			params.require(:teacher).permit(:name, :email, :Mobile_No, :qualification,:gender,:classroom_id, :student_ids)
		end
end