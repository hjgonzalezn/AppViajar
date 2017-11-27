class TarifasController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tarifa, only: [:show, :edit, :update, :destroy]
  before_action :initialize_vars_global, only: [:index, :new, :show, :edit]
  before_action :initialize_vars, only: [:index, :new, :edit, :show]
  
  # GET /tarifas
  # GET /tarifas.json
  def index
    @tarifas = Tarifa.all
  end

  # GET /tarifas/1
  # GET /tarifas/1.json
  def show
    @parent_path = set_parent_path
  end

  # GET /tarifas/new
  def new
    @titulo = "Nueva Tarifa"
    @tarifa = Tarifa.new
  end

  # GET /tarifas/1/edit
  def edit
    @titulo = "Modificar Tarifa"
    @parent_path = set_parent_path
  end

  # POST /tarifas
  # POST /tarifas.json
  def create
    @tarifa = Tarifa.new(tarifa_params)
    @parent_path = set_parent_path
    respond_to do |format|
      if @tarifa.save
        format.html { redirect_to @parent_path , notice: 'Tarifa creada exitosamente.' }
        format.json { render :show, status: :created, location: @tarifa }
      else
        format.html { render :new }
        format.json { render json: @tarifa.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tarifas/1
  # PATCH/PUT /tarifas/1.json
  def update
    respond_to do |format|
      @parent_path = set_parent_path + "/tarifas/" + @tarifa.id.to_s
      if @tarifa.update(tarifa_params)
        format.html { redirect_to @parent_path, notice: 'Tarifa actualizada exitosamente.' }
        format.json { render :show, status: :ok, location: @tarifa }
      else
        format.html { render :edit }
        format.json { render json: @tarifa.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tarifas/1
  # DELETE /tarifas/1.json
  def destroy
    
    @parent_path = set_parent_path
    
    @tarifa.destroy
    respond_to do |format|
      format.html { redirect_to @parent_path, notice: 'Tarifa eliminada exitosamente.' }
      format.json { head :no_content }
    end
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tarifa
      @tarifa = Tarifa.find(params[:id])
    end
    
    def set_parent_path
   
      if @tarifa.nil?
        @ruta = request.fullpath
        @ruta = @ruta.split("/")
        if @ruta.length > 2 then        
          @parentController = @ruta[1]
          @parentId = @ruta[2]
        end
        
        parent_path = "/" + @parentController + "/" + @parentId
        
      else
        case @tarifa.trf_tipoProducto
          when "VEHICULOS"
            @parentController = @tarifa.trf_tipoProducto.downcase
            @parentId = @tarifa.trf_producto.to_s
            parent_path = "/" + @parentController + "/" + @parentId
          when "RUTA"
            @parentController = @tarifa.trf_tipoProducto.downcase
            @parentId = @tarifa.trf_producto.to_s
            parent_path = "/" + @parentController + "/" + @parentId
          when "PAQUETE_TURISTICOS"
            @parentController = @tarifa.trf_tipoProducto.downcase
            @parentId = @tarifa.trf_producto.to_s
            parent_path = "/" + @parentController + "/" + @parentId
        end
      end
            
      return parent_path
    end
  
    def initialize_vars
      
      @parent_path = set_parent_path
      @hshNaturalezaConcept = Hash["DB", "DEBITO", "CR", "CREDITO", "IF", "INFORMATIVA"]
      
      case @parentController
          when "vehiculos"
            @vehiculo = Vehiculo.find(@parentId)
            if @vehiculo.vehi_tipoPropietario == "EMPRESA" then
              empresa = Empresa.where(empr_documentoIdentidad: @vehiculo.vehi_propietarioId).take
              sucursal = SucursalEmpresa.find(@vehiculo.vehi_sucursalEmpresaPropId)
              ciudad = EntidadTerritorial.find(sucursal.sucEmpr_ciudadDomicilio)
            elsif @vehiculo.vehi_tipoPropietario == "ADULTO" then
              persona = Persona.where(pers_documentoIdentidad: @vehiculo.vehi_propietarioId).take
              ciudad = EntidadTerritorial.find(persona.pers_ciudadDomicilio)
            end
            
            @producto = @vehiculo.vehi_modeloCodigo + " (" +ciudad.enter_nombreCorto + ")"
          when "ruta"
            ruta = Rutum.find(@parentId)
            lugaresIds = ruta.ruta_descripcion.split("|")
            @producto = ""
            lugaresIds.each do |id|
              lugar = EntidadTerritorial.find(id)
              @producto = @producto + lugar.enter_nombreCorto +  " > "
            end
            @producto = @producto[0, @producto.length - 3]
          when "paquete_turisticos"
            paqueteTuristico = PaqueteTuristico.find(@parentId)
            @producto = paqueteTuristico.pqTur_nombre
        end
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def tarifa_params
      params.require(:tarifa).permit(:trf_concepto, :trf_conceptoCodigo, :trf_conceptoAplicacion, :trf_detalleAplicacion, :trf_naturaleza, :trf_tipoProducto, :trf_producto, :trf_promo, :trf_econo, :trf_base, :trf_flexi, :trf_deluxe, :trf_unidadCobro, :trf_fechaInicio, :trf_fechaFin, :trf_estadoRegistro)
    end
end
