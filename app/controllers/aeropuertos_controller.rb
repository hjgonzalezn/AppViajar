class AeropuertosController < ApplicationController
  
  include EntidadTerritorialsHelper
  before_action :authenticate_user!
  before_action :set_aeropuerto, only: [:show, :edit, :update, :destroy]
  before_action :initialize_vars_global, only: [:index, :new, :show, :edit]
  before_action :initialize_vars, only: [:new, :edit, :update, :create, :index, :show]
      
  # GET /aeropuertos
  # GET /aeropuertos.json
  def index
    @aeropuertos = Aeropuerto.all
  end

  # GET /aeropuertos/1
  # GET /aeropuertos/1.json
  def show
  end

  # GET /aeropuertos/new
  def new
    @titulo = "Nuevo Aeropuerto"
    @aeropuerto = Aeropuerto.new
  end

  # GET /aeropuertos/1/edit
  def edit
    @titulo = "Modificar Aeropuerto"
  end

  # POST /aeropuertos
  # POST /aeropuertos.json
  def create
    @aeropuerto = Aeropuerto.new(aeropuerto_params)

    respond_to do |format|
      if @aeropuerto.save
        format.html { redirect_to @aeropuerto, notice: 'Aeropuerto creado exitosamente.' }
        format.json { render :show, status: :created, location: @aeropuerto }
      else
        format.html { render :new }
        format.json { render json: @aeropuerto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /aeropuertos/1
  # PATCH/PUT /aeropuertos/1.json
  def update
    respond_to do |format|
      if @aeropuerto.update(aeropuerto_params)
        format.html { redirect_to @aeropuerto, notice: 'Aeropuerto actualizado exitosamente.' }
        format.json { render :show, status: :ok, location: @aeropuerto }
      else
        format.html { render :edit }
        format.json { render json: @aeropuerto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /aeropuertos/1
  # DELETE /aeropuertos/1.json
  def destroy
    @aeropuerto.destroy
    respond_to do |format|
      format.html { redirect_to aeropuertos_url, notice: 'Aeropuerto eliminado exitosamente.' }
      format.json { head :no_content }
    end
  end

  private
    
    def initialize_vars
      @ciudadesColombia = set_ciudades_colombia  
    end
    
    # Use callbacks to share common setup or constraints between actions.
    def set_aeropuerto
      @aeropuerto = Aeropuerto.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def aeropuerto_params
      params.require(:aeropuerto).permit(:aeropt_nombre, :aeropt_codigoIATA, :aeropt_ciudadCdg, :aeropt_estadoRegistro)
    end
end
