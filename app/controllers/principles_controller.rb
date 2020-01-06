class PrinciplesController < ApplicationController
  before_action :set_principle, only: [:show, :edit, :update, :destroy]

  # GET /principles
  # GET /principles.json
  def index
    @principles = Principle.all
  end

  # GET /principles/1
  # GET /principles/1.json
  def show
  end

  # GET /principles/new
  def new
    @principle = Principle.new
  end

  # GET /principles/1/edit
  def edit
  end

  # POST /principles
  # POST /principles.json
  def create
    @principle = Principle.new(principle_params)

    respond_to do |format|
      if @principle.save
      	session[:principle_id] = @principle.id
        format.html { redirect_to @principle, notice: 'Principle was successfully created.' }
        format.json { render :show, status: :created, location: @principle }
      else
        format.html { render :new }
        format.json { render json: @principle.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /principles/1
  # PATCH/PUT /principles/1.json
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

  # DELETE /principles/1
  # DELETE /principles/1.json
  def destroy
    @principle.destroy
    respond_to do |format|
      format.html { redirect_to principles_url, notice: 'Principle was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_principle
      @principle = Principle.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def principle_params
      params.require(:principle).permit(:username, :email, :password, :password_confirmation)
    end
end
