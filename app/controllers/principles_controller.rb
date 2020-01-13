class PrinciplesController < ApplicationController
	#include Checksession
	#before_action :set_school
	#before_action :check_session_for_principle, only:[:index]
	before_action :set_principle, only: [:show, :edit, :update, :destroy]
	def index
		@principles = Principle.all
	end

	def show
	end

	def new
		@principle = Principle.new
	end

	def edit
	end

	def create
		@principle = Principle.new(principle_params)
		respond_to do |format|
			if @principle.save
				session[:principle_id] = @principle.id
				format.html { redirect_to school_index_url, notice: "#{@principle.username } PRINCIPLE CREATED." }
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
		@principle.destroy
		respond_to do |format|
			format.html { redirect_to principles_url, notice: 'Principle was successfully destroyed.' }
			format.json { head :no_content }
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
			params.require(:principle).permit(:username, :email, :password, :password_confirmation,:school_id)
		end

		def deactivate
			principle = Principle.find(params[:principle_id])
			if current_principle.status?
				principle.deactivate_account!
				redirect_to principles_path 
		else
				redirect_to :back
		end
end
end
