class VehiculosController < ApplicationController
  
  include VehiculosHelper
  include PersonasHelper
  include EmpresasHelper
  
  before_action :authenticate_user!  
  before_action :set_vehiculo, only: [:show, :edit, :update, :destroy]
  before_action :initialize_vars_global, only: [:index, :new, :show, :edit]
  before_action :initialize_vars, only: [:index, :new, :edit, :show]
  
  # GET /vehiculos
  # GET /vehiculos.json
  def index
    @vehiculos = Vehiculo.all.order(:vehi_tipo)
  end

  # GET /vehiculos/1
  # GET /vehiculos/1.json
  def show
    @tarifas = Tarifa.where("trf_conceptoCodigo = 'VVIAJ' AND trf_conceptoAplicacion = 'RUTA' AND trf_tipoProducto = 'VEHICULOS' and trf_producto = #{@vehiculo.id} AND trf_estadoRegistro = 'A'")
    @delete_path = request.fullpath + "/tarifas/"
  end

  # GET /vehiculos/new
  def new
    @titulo = "Nuevo vehículo"
    @vehiculo = Vehiculo.new
    @tipoIdPropietario = ""
    @nroIdPropietario = ""
    @sucursales = Hash.new
  end

  # GET /vehiculos/1/edit
  def edit
    @titulo = "Modificar vehículo"
    @tipoIdPropietario = @vehiculo.vehi_propietarioId[-2,2]
    @nroIdPropietario = @vehiculo.vehi_propietarioId[0,@vehiculo.vehi_propietarioId.length - 2]
    @sucursales = set_sucursales_empresa(@vehiculo.vehi_propietarioId)
    @sucursales = @sucursales.map{|h| [h.id, h.sucEmpr_nombreSucursal]}.to_h
  end

  # POST /vehiculos
  # POST /vehiculos.json
  def create
    @vehiculo = Vehiculo.new(vehiculo_params)

    respond_to do |format|
      if @vehiculo.save
        format.html { redirect_to @vehiculo, notice: 'Vehiculo creado exitosamente.' }
        format.json { render :show, status: :created, location: @vehiculo }
      else
        format.html { render :new }
        format.json { render json: @vehiculo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vehiculos/1
  # PATCH/PUT /vehiculos/1.json
  def update
    respond_to do |format|
      if @vehiculo.update(vehiculo_params)
        format.html { redirect_to @vehiculo, notice: 'Vehiculo actualizado exitosamente.' }
        format.json { render :show, status: :ok, location: @vehiculo }
      else
        format.html { render :edit }
        format.json { render json: @vehiculo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vehiculos/1
  # DELETE /vehiculos/1.json
  def destroy
    @vehiculo.destroy
    respond_to do |format|
      format.html { redirect_to vehiculos_url, notice: 'Vehiculo eliminado exitosamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vehiculo
      @vehiculo = Vehiculo.find(params[:id])
    end

    def initialize_vars
      @tiposVehiculo = set_tipos_vehiculo
      @tiposIdentPersona = set_tipos_id_persona("ADULTO")
      @tiposIdentEmpresa = set_tipos_id_empresa
      @tiposId = Hash.new
      @datosPropietario = Hash.new
      @datosPropietario["nombre"] = ""
      @datosPropietario["ciudad"] = ""
    
      unless @vehiculo.nil?
        @datosPropietario = set_propietario_vehiculo(@vehiculo.vehi_tipoPropietario, @vehiculo.vehi_propietarioId, @vehiculo.vehi_sucursalEmpresaPropId)
        
        if @vehiculo.vehi_tipoPropietario == "EMPRESA" then
          @tiposId = @tiposIdentEmpresa.invert
        elsif @vehiculo.vehi_tipoPropietario == "ADULTO" then
          @tiposId = @tiposIdentPersona.invert
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vehiculo_params
      params.require(:vehiculo).permit(:vehi_tipo, :vehi_modeloCodigo, :vehi_nombre, :vehi_matricula, :vehi_propietarioId, :vehi_tipoPropietario, :vehi_sucursalEmpresaPropId, :vehi_capacPesoMaximo, :vehi_capacPesoPasajeros, :vehi_capacCargaBodega, :vehi_capacPasajeros, :vehi_foto, :vehi_estadoRegistro)
    end
end
