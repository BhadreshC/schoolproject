class ClassroomsController < ApplicationController
	include Checksession
	before_action :check_session
	before_action :set_school
	before_action :set_classroom, only: [:show, :edit, :update, :destroy]

	def index
		@classrooms = @school.classrooms
	end

	def show
		@classrooms= @school.classrooms
		@classroom = @classrooms.find_by_id(params[:id])
		@totalstudent= 5
		@classstudents=@classrooms.find_by_id(params[:id]).students
		@classteachers=@classrooms.find_by_id(params[:id]).teachers
		respond_to do |format|
			format.html
			format.csv { send_data @classroom.to_csv, filename: "classrooms-#{Date.today}.csv" }
		end
	end

	def new
		@classroom = @school.classrooms.new
	end

	def edit; end

	def create
		@classroom = @school.classrooms.new(classroom_params)
		respond_to do |format|
			if @classroom.save
				format.html { redirect_to school_classroom_path(@school, @classroom), notice: 'Classroom was successfully created.' }
				format.json { render :show, status: :created, location: @classroom }
			else
				format.html { render :new }
				format.json { render json: @classroom.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
		respond_to do |format|
			if @classroom.update(classroom_params)
				format.html { redirect_to school_classroom_path(@school, @classroom), notice: 'Classroom was successfully updated.' }
				format.json { render :show, status: :ok, location: @classroom }
			else
				format.html { render :edit }
				format.json { render json: @classroom.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@classroom.destroy
		respond_to do |format|
			format.html { redirect_to school_classrooms_url, notice: 'Classroom was successfully destroyed.' }
			format.json { head :no_content }
		end
	end

	private
		def set_school
			@school = School.find_by(id: params[:school_id])
		end

		def set_classroom
			@classroom = @school.classrooms.find_by(id: params[:id])
		end

		def classroom_params
			params.require(:classroom).permit(:C_Name, :wichstandard, :school_id)
		end
end
