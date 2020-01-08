class TeachersController < ApplicationController
	#include Checksession
	before_action :set_teacher, only: [:show, :edit, :update, :destroy]
	#before_action :check_session

	def index
		@teachers = Teacher.all
		respond_to do |format|
      format.html
      format.csv { send_data @teachers.to_csv, filename: "teachers-#{Date.today}.csv" }
   end
	end

	def show
	end

	def new
		@teacher = Teacher.new
	end

	def edit
	end

	def create
		@teacher = Teacher.new(teacher_params)
		respond_to do |format|
			if @teacher.save
				format.html { redirect_to @teacher, notice: 'Teacher was successfully created.' }
				format.json { render :show, status: :created, location: @teacher }
			else
				format.html { render :new }
				format.json { render json: @teacher.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
		respond_to do |format|
		if @teacher.update(teacher_params)
			format.html { redirect_to @teacher, notice: 'Teacher was successfully updated.' }
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
			format.html { redirect_to teachers_url, notice: 'Teacher was successfully destroyed.' }
			format.json { head :no_content }
		end
	end

	private
		def set_teacher
			@teacher = Teacher.find(params[:id])
		end
		def teacher_params
			params.require(:teacher).permit(:name, :email)
		end
end
