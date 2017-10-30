class RutaController < ApplicationController
  include EntidadTerritorialsHelper

  before_action :authenticate_user!  
  before_action :set_rutum, only: [:show, :edit, :update, :destroy]
  before_action :initialize_vars_global, only: [:index, :new, :show, :edit]
  before_action :initialize_vars, only: [:new, :edit, :show]

  # GET /ruta
  # GET /ruta.json
  def index
    @ruta = Rutum.all
  end

  # GET /ruta/1
  # GET /ruta/1.json
  def show
    @tarifas = Tarifa.where("trf_conceptoCodigo = 'VLPAX' AND trf_conceptoAplicacion = 'RUTA' AND trf_tipoProducto = 'RUTA' and trf_producto = #{@rutum.id} AND trf_estadoRegistro = 'A'")
    @delete_path = request.fullpath + "/tarifas/"
  end

  # GET /ruta/new
  def new
    @titulo = "Nueva Ruta"
    @rutum = Rutum.new
  end

  # GET /ruta/1/edit
  def edit
    @titulo = "Modificar Ruta"
    @estacion1 = nil
    @estacion2 = nil
    @estacion3 = nil
    @estacion4 = nil
    
    unless @rutum.ruta_descripcion.nil?
      arrEstaciones = @rutum.ruta_descripcion.split("|")
      @estacion1 = arrEstaciones[0]
      @estacion2 = arrEstaciones[1]
      @estacion3 = arrEstaciones[2]
      @estacion4 = arrEstaciones[3]
    end
  end

  # POST /ruta
  # POST /ruta.json
  def create
    @rutum = Rutum.new(rutum_params)

    respond_to do |format|
      if @rutum.save
        format.html { redirect_to @rutum, notice: 'Ruta creada exitosamente.' }
        format.json { render :show, status: :created, location: @rutum }
      else
        format.html { render :new }
        format.json { render json: @rutum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ruta/1
  # PATCH/PUT /ruta/1.json
  def update
    respond_to do |format|
      if @rutum.update(rutum_params)
        format.html { redirect_to @rutum, notice: 'Ruta actualizada exitosamente.' }
        format.json { render :show, status: :ok, location: @rutum }
      else
        format.html { render :edit }
        format.json { render json: @rutum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ruta/1
  # DELETE /ruta/1.json
  def destroy
    @rutum.destroy
    respond_to do |format|
      format.html { redirect_to ruta_url, notice: 'Ruta eliminada exitosamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rutum
      @rutum = Rutum.find(params[:id])
    end
    
    def initialize_vars
      @entidadesColombia = set_entidades_colombia
    end
        
    # Never trust parameters from the scary internet, only allow the white list through.
    def rutum_params
      params.require(:rutum).permit(:ruta_medio, :ruta_prioridad, :ruta_descripcion, :ruta_frecuencia, :ruta_vehiculo, :ruta_estadoRegistro)
    end
end
