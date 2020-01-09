class SchoolController < ApplicationController
	include Checksession
	before_action :check_session
	before_action :set_school, only: [:show, :edit, :update, :destroy]

	def index
		@schools = School.includes(:Principle)

	end

	def edit
	end

	def show
			@classroomscount= @school.classrooms
			@principles = Principle.order("created_at").all
			@record = @principles.last
			
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
			@school = School.find(params[:id])
		end

		def school_params
			params.require(:school).permit(:name, :princile)
		end
		
end
