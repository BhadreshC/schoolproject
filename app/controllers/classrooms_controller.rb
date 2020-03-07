class ClassroomsController < ApplicationController
	include Checksession
	before_action :set_school
	before_action :set_classroom, only: [:show, :edit, :update, :destroy,:updateclass]
	before_action :check_session, :check_permission
	def index
		@classrooms = @school.classrooms.order(:standard)
	end

	def show
		@classrooms= @school.classrooms
		@classroom = @classrooms.find_by_id(params[:id])
		@totalstudent = 5
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

	def upgradeclass
		@classrooms= @school.classrooms
		@classroom = @classrooms.find_by_id(params[:id])
		@classstudents=@classrooms.find_by_id(params[:id]).students
		@studname=@classstudents
	end

	def updateclass
		# puts params[:classroom_id][:id]
		@selectedstudents = @classroom.students.where(id: params[:student_ids])
		@teachers = Teacher.where(classroom_id: params[:classroom_id][:id])
		puts @teachers.as_json
		@teachers.each do |t|
			t.students << @selectedstudents
		end
		puts @selectedstudents.as_json
		@noofupdatedstd = @selectedstudents.update_all(classroom_id: params[:classroom_id][:id])
		respond_to do |format|
			if @noofupdatedstd
				# puts @selectedstudents.as_json
				@selectedstudents.each do |std|
					@newclassroom = Classroom.find_by_id(params[:classroom_id][:id])
					Activity.create_activity("#{std.name }is passed from #{std.classroom.C_Name} to #{@newclassroom.C_Name}", std)
				end
				format.html { redirect_to school_classroom_path(@school, @classroom), notice: "#{@noofupdatedstd} students passed " }
				format.json { render :show, status: :ok, location: @classroom }
			else
				format.html { redirect_to upgradeclass_school_classroom_path(@school, @classroom), notice: 'Something went wrong'}
				format.json { render json: @classroom.errors, status: :unprocessable_entity }
			end
		end
	end

	private
		def set_school
			@school = School.find_by(id: params[:school_id]) or not_found
		end

		def set_classroom
			@classroom = @school.classrooms.find_by(id: params[:id]) or not_found
		end

		def classroom_params
			params.require(:classroom).permit(:C_Name, :standard, :school_id)
		end
end
