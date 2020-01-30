class PrinciplesController < ApplicationController
	include Checksession
	before_action :check_session, only: [:new]
	before_action :set_principle, only: [:show, :edit, :update, :destroy]
	before_action :set_school

	def new
		@principle= @school.principles.new
	end

	def create
		@principle = @school.principles.new(principle_params)
		respond_to do |format|
			if @principle.save
				session[:principle_id] = @principle.id
				format.html { redirect_to school_path(@school), notice: "Confirmation mail has been sended to the #{@principle.email },Please confim the mail after you can login " }
				format.json { render :show, status: :created, location: @principle }
			else
				format.html { render :new }
				format.json { render json: @principle.errors, status: :unprocessable_entity }
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
			params.require(:principle).permit(:username, :email, :password, :password_confirmation)
		end
end
