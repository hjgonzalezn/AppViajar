class CausalsController < ApplicationController
  before_action :set_causal, only: [:show, :edit, :update, :destroy]
  before_action :initialize_vars_global, only: [:index, :new, :show, :edit]
  before_action :initialize_vars, only: [:new, :edit, :show]
  
  # GET /causals
  # GET /causals.json
  def index
    @causals = Causal.all
  end

  # GET /causals/1
  # GET /causals/1.json
  def show
  end

  # GET /causals/new
  def new
    @titulo = "Nueva Causal"
    @causal = Causal.new
  end

  # GET /causals/1/edit
  def edit
    @titulo = "Modificar causal"
  end

  # POST /causals
  # POST /causals.json
  def create
    @causal = Causal.new(causal_params)

    respond_to do |format|
      if @causal.save
        format.html { redirect_to @causal, notice: 'Causal was successfully created.' }
        format.json { render :show, status: :created, location: @causal }
      else
        format.html { render :new }
        format.json { render json: @causal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /causals/1
  # PATCH/PUT /causals/1.json
  def update
    respond_to do |format|
      if @causal.update(causal_params)
        format.html { redirect_to @causal, notice: 'Causal was successfully updated.' }
        format.json { render :show, status: :ok, location: @causal }
      else
        format.html { render :edit }
        format.json { render json: @causal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /causals/1
  # DELETE /causals/1.json
  def destroy
    @causal.destroy
    respond_to do |format|
      format.html { redirect_to causals_url, notice: 'Causal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_causal
      @causal = Causal.find(params[:id])
    end
    
    def initialize_vars
      
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def causal_params
      params.require(:causal).permit(:causal_tipo, :causal_nivel, :causal_descripcion, :causal_solucion, :causal_estadoRegistro)
    end
end
