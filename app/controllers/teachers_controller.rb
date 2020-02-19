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
		@teacher_activities = Activity.where(activeable_id: params[:id])
	end

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
		respond_to do |format|
			if @teacher.update(teacher_params)

				if @teacher.saved_change_to_name?
					Activity.create_activity("update name from  #{@teacher.name_before_last_save} to  #{@teacher.name}" , @teacher)
				end

				if @teacher.saved_change_to_email?
					Activity.create_activity("update email from  #{@teacher.email_before_last_save} to  #{@teacher.email}" , @teacher)
				end

				if @teacher.saved_change_to_qualification?
					Activity.create_activity("update qualification from  #{@teacher.qualification_before_last_save} to  #{@teacher.qualification}" , @teacher)
				end

				if @teacher.saved_change_to_MobileNo?
					Activity.create_activity("update qualification from  #{@teacher.MobileNo_before_last_save} to  #{@teacher.MobileNo}" , @teacher)
				end
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
