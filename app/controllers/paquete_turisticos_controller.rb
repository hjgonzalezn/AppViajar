class PaqueteTuristicosController < ApplicationController
  include EntidadTerritorialsHelper
  include ActividadTuristicasHelper
  
  before_action :set_paquete_turistico, only: [:show, :edit, :update, :destroy, :detalle_plan, :actividades_plan, :registrar_actividades]
  before_action :initialize_vars_global, only: [:index, :new, :show, :edit, :detalle_plan, :actividades_plan]
  before_action :initialize_vars, only: [:new, :edit, :show, :detalle_plan]
  
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
    @itinerario = Itinerario.where("paquete_turistico_id = ? AND itnr_estadoRegistro = 'A'", @paquete_turistico)
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
    @ciudadesOrigen = EntidadTerritorial.select("id, enter_nombreCorto").where("enter_nombreCorto IN ('MEDELLIN', 'CALI', 'BOGOTA DC')")
    @fotosPlan = Foto.select("fotos.foto_nombreArchivo, E.enter_nombreCorto").joins("INNER JOIN entidad_territorials E ON E.id = fotos.foto_entidad_id INNER JOIN paq_turistico_ent_territorials PE ON PE.Entidad_Territorial_Id = E.id INNER JOIN paquete_turisticos PT ON PT.id = PE.paquete_turistico_id").where("fotos.foto_entidadCodigo = 'ENTER' AND fotos.foto_estadoRegistro = 'A' AND E.enter_estadoRegistro = 'A' AND PE.PqTurEnTer_estadoRegistro = 'A' AND PT.pqTur_EstadoRegistro = 'A' AND PT.id = ?", @paquete_turistico.id)
  end
  
  def actividades_plan
    @actividad_turisticas = set_actividades_plan(@paquete_turistico.id)
  end
  
  def registrar_actividades
    
    unless params[:chkActividad].nil?
      index = 0 
      params[:chkActividad].each do |h|
        actividadPlan = ActividadTuristicaPlan.new
        actividadPlan.paquete_turistico_id = @paquete_turistico.id
        actividadPlan.actividad_turistica_id = h
        actividadPlan.atp_clasificacion = params[:atp_clasificacion][index]
        actividadPlan.atp_estadoRegistro = "A"
        actividadPlan.save
        index += 1
      end
    end

    respond_to do |format| 
      format.html { redirect_to @paquete_turistico, notice: 'Actividades turísticas actualizadas exitosamente.' }
      format.json { render :show, status: :created, location: @paquete_turistico }
    #else
    #  format.html { render :new }
    #  format.json { render json: @paquete_turistico.errors, status: :unprocessable_entity }
    end
    
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
      instSQL_Joins = "INNER JOIN paquete_turisticos P ON (P.id = salidas.paquete_turistico_id) INNER JOIN reservas R ON (R.rsrv_productoId = P.id AND R.rsrv_tipoProducto = 'PLAN') INNER JOIN detalle_reservas DR ON DR.reserva_id = R.id"
      @continentes = set_continentes
      @padreRegion = EntidadTerritorial.where("enter_nivel IN (1,2) AND enter_estadoRegistro = 'A'").order(:enter_nivel, :enter_nombreCorto)
      
      if params[:action] != "new" then
        @tarifas = Tarifa.where("trf_tipoProducto = 'PAQUETE_TURISTICOS' AND trf_producto = ? AND trf_estadoRegistro = 'A'", @paquete_turistico.id).order(:trf_detalleAplicacion)
        @itinerario = Itinerario.where(paquete_turistico_id: @paquete_turistico)
        
        instSQL_Joins = "INNER JOIN actividad_turistica_plans ATP ON ATP.actividad_turistica_id = actividad_turisticas.id INNER JOIN paquete_turisticos PT ON ATP.paquete_turistico_id = PT.id INNER JOIN tipo_actividad_turisticas TAT ON actividad_turisticas.tipo_actividad_turistica_id = TAT.id "
        @actividad_turisticas = ActividadTuristica.select("actividad_turisticas.actur_descripcion descripcion, TAT.tiAcT_nombre tipo_actividad, ATP.atp_clasificacion clasificacion").joins(instSQL_Joins).where("PT.id = #{@paquete_turistico.id} AND actividad_turisticas.actur_estadoRegistro = 'A' AND  ATP.atp_estadoRegistro = 'A' AND PT.pqTur_estadoRegistro = 'A'")
        
        @salidas = Salida.select("sld_fecha, salidas.id, (SELECT count(*) FROM paquete_turisticos PT INNER JOIN reservas R ON (R.rsrv_tipoProducto = 'PLAN' AND R.rsrv_productoId = PT.id) INNER JOIN detalle_reservas DR ON R.id = DR.reserva_id WHERE R.rsrv_fechaIda = salidas.sld_fecha) nro_viajeros").where("sld_fecha >= sysdate() AND paquete_turistico_id = ? AND sld_estadoRegistro = ?", @paquete_turistico, 'A')
      end
      
      @clasifActividad = {"OP" => "OPCIONAL", "PB" => "PLAN BÁSICO"}
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def paquete_turistico_params
      params.require(:paquete_turistico).permit(:pqTur_nombre, :pqTur_tipoDestino, :pqTur_destino, :pqTur_portada, :pqTur_descripcion, :pqTur_incluye, :pqTur_noIncluye, :pqTur_opcionales, :pqTur_recomendaciones, :pqTur_fechaVigenciaIni, :pqTur_fechaVigenciaFin, :pqTur_fechaPromocionIni, :pqTur_fechaPromocionFin, :pqTur_estadoRegistro, :itinerario)
    end
end
