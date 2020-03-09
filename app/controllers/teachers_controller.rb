class TeachersController < ApplicationController
	include Checksession
	before_action :set_teacher, only: [:show, :edit, :update, :destroy]
	before_action :set_school
	before_action :check_session, :check_permission

	def index
		@teachers = Teacher.joins(:classroom).where("classrooms.school_id = ? " , @school)
		@schoolclass = @school.classrooms
	end

	def show
		@teacher_activities = Activity.where(activeable_id: params[:id], activeable_type: "Teacher")
	end

	def new
		@teacher = Teacher.new
		@schoolclassrooms = @school.classrooms.all
	end

	def edit
		@schoolclassrooms = @school.classrooms.all
	end

	def create
		@teacher = Teacher.new(teacher_params)
		@stud = Student.where(classroom_id: params[:teacher][:classroom_id])
		@stud.each do |s|
			s.teachers << @teacher
		end
		@schoolclassrooms = @school.classrooms.all
		Activity.create_activity("new teacher is #{@teacher.name}", @teacher)
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
		@teacher.attributes = teacher_params
		change_val = @teacher.changes
		respond_to do |format|
			if @teacher.save
				@teacher.changed_attributes(change_val, @teacher)
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
			@school = School.find_by(id: params[:school_id]) or not_found
		end

		def set_teacher
			@teacher = Teacher.find_by(id: params[:id]) or not_found
		end

		def teacher_params
			params.require(:teacher).permit(:name, :email, :MobileNo, :qualification,:gender,:classroom_id, :student_ids)
		end
end
