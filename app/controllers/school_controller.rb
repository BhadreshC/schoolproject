class SchoolController < ApplicationController
	include Checksession
	before_action :check_session
	before_action :set_school, only: [:show, :edit, :update, :destroy]
	before_action :check_for_direct_access, only:[:show]
	def index
	end

	def edit;end

	def show
			@no_of_student=Student.joins(:classroom).where("classrooms.school_id = ? " , params[:id])
			@no_of_teacher=Teacher.joins(:classroom).where("classrooms.school_id = ? " , params[:id])
			@classroomscount= @school.classrooms
			@schoolprinciple= @school.principles.order("created_at").all
	end

	def new
		@schoolclassrooms = @school.classrooms
	end

	def created_at
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
			@school = School.find_by(id: params[:id])
		end

		def school_params
			params.require(:school).permit(:name, :principle)
		end
end
