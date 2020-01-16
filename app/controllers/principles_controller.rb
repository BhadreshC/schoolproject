class PrinciplesController < ApplicationController
	before_action :set_principle, only: [:show, :edit, :update, :destroy]
	before_action :set_school
	def index
		@principles = Principle.all
	end

	def show; end

	def new
		@principle= @school.principles.new
	end

	def edit; end

	def create
		@principle = @school.principles.new(principle_params)
		@school = @principle.school
		@schoolprinciples = @school.principles
		@schoolprinciples.update_all status: false
		respond_to do |format|
			if @principle.save
				session[:principle_id] = @principle.id
				format.html { redirect_to school_path(@school), notice: "#{@principle.username } PRINCIPLE CREATED." }
				format.json { render :show, status: :created, location: @principle }
			else
				format.html { render :new }
				format.json { render json: @principle.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
		respond_to do |format|
			if @principle.update(principle_params)
				format.html { redirect_to @principle, notice: 'Principle was successfully updated.' }
				format.json { render :show, status: :ok, location: @principle }
			else
				format.html { render :edit }
				format.json { render json: @principle.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		if @principle.status == true
			puts @previous = @principle.school.principles.second_to_last
			@previous= @previous.update(:status => true)
			@principle.destroy
			respond_to do |format|
				format.html { redirect_to principles_url, notice: 'Principle was successfully destroyed.' }
				format.json { head :no_content }
			end
		else
			@principle.destroy
			respond_to do |format|
				format.html { redirect_to principles_url, notice: 'Principle was successfully destroyed.' }
				format.json { head :no_content }
			end
		end
	end

	private
		def set_school
			@school = School.find_by(id: params[:school_id])
		end

		def set_principle
			@principle = Principle.find_by(id: params[:id])
		end

		def principle_params
			params.require(:principle).permit(:username, :email, :password, :password_confirmation )
		end
end
