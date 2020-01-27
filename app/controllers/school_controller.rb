class SchoolController < ApplicationController
	include Checksession
	before_action :set_school, only: [:show, :edit, :update, :destroy]
	before_action :check_session
	before_action :check_permission, only: [:show]

	def index
		redirect_to root_url
	end

	def edit;end

	def show
			@schoolprinciple= @school.principles.order("created_at").all
			@no_of_student=Student.joins(:classroom).where("classrooms.school_id = ? " , params[:id])
			@no_of_teacher=Teacher.joins(:classroom).where("classrooms.school_id = ? " , params[:id])
			@classroomscount= @school.classrooms
	end

	def new
		@schoolclassrooms = @school.classrooms
	end

	def create
		@school = School.new(school_params)
		respond_to do |format|
			if @school.save
				format.html { redirect_to @school, notice: 'school was successfully created.' }
				format.json { render :show, status: :created, location: @school }
			else
				format.html { render :new }
				format.json { render json: @school.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
		respond_to do |format|
			if @school.update(school_params)
				format.html { redirect_to @school, notice: 'school was successfully updated.' }
				format.json { render :show, status: :ok, location: @school }
			else
				format.html { render :edit }
				format.json { render json: @school.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@school.destroy
		respond_to do |format|
			format.html { redirect_to schools_url, notice: 'school was successfully destroyed.' }
			format.json { head :no_content }
		end
	end

	private
		def set_school
			@school = School.find_by(id: params[:id]) or not_found
		end

		def school_params
			params.require(:school).permit(:name, :principle)
		end

		def check_permission
			@principles = @school.principles
			if @principles.exists?(current_principle.id) or not_found
			else
			end
		end
end
