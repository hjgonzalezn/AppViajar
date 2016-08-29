class PaqueteTuristicosController < ApplicationController
  include EntidadTerritorialsHelper
  
  before_action :set_paquete_turistico, only: [:show, :edit, :update, :destroy, :detalle_plan]
  before_action :initialize_vars_global, only: [:index, :new, :show, :edit]
  before_action :initialize_vars, only: [:new, :edit, :show]
  
  # GET /paquete_turisticos
  # GET /paquete_turisticos.json
  def index
    @paquete_turisticos = PaqueteTuristico.all
  end

  # GET /paquete_turisticos/1
  # GET /paquete_turisticos/1.json
  def show
  end

  # GET /paquete_turisticos/new
  def new
    @titulo = "Nuevo Paquete Turístico"
    @paquete_turistico = PaqueteTuristico.new
  end

  # GET /paquete_turisticos/1/edit
  def edit
    @titulo = "Modificar Paquete Turístico"
    @tipos_actividad_turistica = TipoActividadTuristica.all
    @tarifas = Tarifa.where("trf_conceptoCodigo = 'VPAQ' AND trf_conceptoAplicacion = 'PAQUETE' AND trf_tipoProducto = 'PAQUETE TURISTICO' and trf_producto = #{@paquete_turistico.id} AND trf_estadoRegistro = 'A'")
    @itinerario = Itinerario.where(paquete_turistico_id: @paquete_turistico)
  end

  # POST /paquete_turisticos
  # POST /paquete_turisticos.json
  def create
    @paquete_turistico = PaqueteTuristico.new(paquete_turistico_params)

    respond_to do |format|
      if @paquete_turistico.save
        format.html { redirect_to @paquete_turistico, notice: 'Paquete turistico creado exitosamente.' }
        format.json { render :show, status: :created, location: @paquete_turistico }
      else
        format.html { render :new }
        format.json { render json: @paquete_turistico.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /paquete_turisticos/1
  # PATCH/PUT /paquete_turisticos/1.json
  def update
    respond_to do |format|    
      if @paquete_turistico.update(paquete_turistico_params) then
        Itinerario.where(paquete_turistico_id: @paquete_turistico).destroy_all
        arrItinerarios = params[:itinerario][:dia]
        
        arrItinerarios.each do |t|
          if t != "" then
            itinerario = Itinerario.new
            itinerario.paquete_turistico_id = @paquete_turistico.id
            itinerario.itnr_actividad = t
            itinerario.itnr_estadoRegistro = "A"
            itinerario.save
          end
        end
        
        format.html { redirect_to @paquete_turistico, notice: 'Paquete turistico actualizado exitosamente.' }
        format.json { render :show, status: :ok, location: @paquete_turistico }
      else
        format.html { render :edit }
        format.json { render json: @paquete_turistico.errors, status: :unprocessable_entity }
      end
    end
  end

  def detalle_plan
    @itinerario = Itinerario.where(paquete_turistico_id: @paquete_turistico)
  end
  
  # DELETE /paquete_turisticos/1
  # DELETE /paquete_turisticos/1.json
  def destroy
    @paquete_turistico.destroy
    respond_to do |format|
      format.html { redirect_to paquete_turisticos_url, notice: 'Paquete turistico eliminado exitosamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_paquete_turistico
      @paquete_turistico = PaqueteTuristico.find(params[:id])
    end
    
    def initialize_vars
      @continentes = set_continentes
      @padreRegion = EntidadTerritorial.where("enter_nivel IN (1,2) AND enter_estadoRegistro = 'A'").order(:enter_nivel, :enter_nombreCorto)
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def paquete_turistico_params
      params.require(:paquete_turistico).permit(:pqTur_nombre, :pqTur_tipoDestino, :pqTur_destino, :pqTur_portada, :pqTur_descripcion, :pqTur_incluye, :pqTur_noIncluye, :pqTur_opcionales, :pqTur_recomendaciones, :pqTur_fechaVigenciaIni, :pqTur_fechaVigenciaFin, :pqTur_fechaPromocionIni, :pqTur_fechaPromocionFin, :pqTur_estadoRegistro, :itinerario)
    end
end
