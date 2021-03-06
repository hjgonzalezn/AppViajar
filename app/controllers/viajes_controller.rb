class ViajesController < ApplicationController
  include AeropuertosHelper
  include RutaHelper
  
  before_action :authenticate_user!
  after_action :verify_authorized
  before_action :set_viaje, only: [:show, :edit, :update, :destroy]
  before_action :initialize_vars_global, only: [:index, :new, :show, :edit]
  before_action :initialize_vars, only: [:index, :new, :edit, :show]
  
  # GET /viajes
  # GET /viajes.json
  def index
    authorize Viaje
    
    @periodoViaje = nil 
    unless params[:txtRangoFechasViaje].blank?
      @periodoViaje = params[:txtRangoFechasViaje].split(" a ")
    end
    
    @ciudadViaje = params[:cboCiudad]
    @rangoFechas = params[:txtRangoFechasViaje]
    
    instSQL_Select = "viajes.*, vc.vehi_capacPasajeros" 
    instSQL_Where = "viajes.viaje_estadoRegistro = 'A'"
    instSQL_joins = "INNER JOIN ruta R ON viaje_ruta = R.id INNER JOIN vehiculos vc ON viajes.vehiculo_id = vc.id "

    unless @periodoViaje.blank?
      instSQL_Where = instSQL_Where + " AND viajes.viaje_fecha BETWEEN CAST('#{@periodoViaje[0]}' AS DATE) AND CAST('#{@periodoViaje[1]}' AS DATE)"
    end
    
    unless @ciudadViaje.blank?
      instSQL_Where = instSQL_Where + " AND  R.ruta_descripcion LIKE '%#{@ciudadViaje}%' AND viajes.viaje_estadoRegistro = 'A' AND vc.vehi_estadoRegistro = 'A'"
    end
    
    
    @ciudadesAeropuertos = set_ciudades_aeropuertos
    @viajes = Viaje.select(instSQL_Select).where(instSQL_Where).joins(instSQL_joins).order(viaje_fecha: :asc)
  end

  # GET /viajes/1
  # GET /viajes/1.json
  def show
    authorize @viaje
    
    @ruta = Rutum.find(@viaje.viaje_ruta)
    @lugares = set_descripcion_ruta(@ruta.ruta_descripcion)
    
    instSQL_select = " reservas.id
                      ,reservas.rsrv_codigo codigoReserva
                      ,reservas.rsrv_trayectoViaje trayectoViaje
                      ,reservas.created_at fechaReserva
                      ,P1.pers_documentoIdentidad documIdentContacto
                      ,P1.pers_nombres nombreContacto
                      ,P1.pers_apellidos apellidosContacto
                      ,P2.pers_documentoIdentidad documIdentCliente
                      ,P2.pers_nombres nombreCliente
                      ,P2.pers_apellidos apellidosCliente
                      ,DR.detRsrv_estadoReserva"
    instSQL_conditions = "reservas.rsrv_estadoRegistro = 'A'
                          AND DR.detRsrv_estadoRegistro = 'A'
                          AND reservas.rsrv_tipoProducto = 'VUELO'
                          AND V.id = " + @viaje.id.to_s
    instSQL_joins = "INNER JOIN detalle_reservas DR ON reservas.id = DR.reserva_id
                     INNER JOIN viajes V ON reservas.rsrv_productoId = V.id
                     INNER JOIN personas P1 ON P1.pers_documentoIdentidad = reservas.rsrv_contactoId 
                     INNER JOIN personas P2 ON P2.pers_documentoIdentidad = DR.detRsrv_clienteId "
                     
    rsrvViajes = Reserva.select(instSQL_select).joins(instSQL_joins).where(instSQL_conditions).order("reservas.rsrv_trayectoViaje, reservas.created_at, codigoReserva")
    @rsrvsPendientes = []
    @rsrvsConfirmadas = []
    @rsrvsCanceladas = []
    
    rsrvViajes.each do |h|
      if h.detRsrv_estadoReserva == "I" then
        @rsrvsPendientes.push(h)
      elsif h.detRsrv_estadoReserva == "C" || h.detRsrv_estadoReserva == "B" then
        @rsrvsConfirmadas.push(h)
      elsif h.detRsrv_estadoReserva == "N" then
        @rsrvsCanceladas.push(h)
      end      
    end
  end

  # GET /viajes/new
  def new
    @titulo = "Nuevo viaje"
    @viaje = Viaje.new
    authorize @viaje
  end

  # GET /viajes/1/edit
  def edit
    authorize @viaje
    @titulo = "Modificar viaje"
  end

  # POST /viajes
  # POST /viajes.json
  def create
    @viaje = Viaje.new(viaje_params)
    authorize @viaje
    
    respond_to do |format|
      if @viaje.save
        format.html { redirect_to @viaje, notice: 'Viaje creado exitosamente.' }
        format.json { render :show, status: :created, location: @viaje }
      else
        format.html { render :new }
        format.json { render json: @viaje.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /viajes/1
  # PATCH/PUT /viajes/1.json
  def update
    authorize current_user
    respond_to do |format|
      if @viaje.update(viaje_params)
        format.html { redirect_to @viaje, notice: 'Viaje actualizado exitosamente.' }
        format.json { render :show, status: :ok, location: @viaje }
      else
        format.html { render :edit }
        format.json { render json: @viaje.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /viajes/1
  # DELETE /viajes/1.json
  def destroy
    authorize @viaje
    @viaje.destroy
    respond_to do |format|
      format.html { redirect_to viajes_url, notice: 'Viaje eliminado exitosamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_viaje
      @viaje = Viaje.find(params[:id])
    end
    
    def initialize_vars
      @rutasViaje = {}
      rutas = Rutum.where(ruta_EstadoRegistro: :A).order("ruta_prioridad ASC, ruta_descripcion ASC")
      rutas.each do |h|
        descripcionRuta = set_descripcion_ruta(h.ruta_descripcion)
        @rutasViaje[h.id] = h.ruta_medio + "|" + descripcionRuta
      end
      
      @estadosViaje = Catalogo.select("ctlg_valorCdg, ctlg_valorDesc").where("ctlg_categoria = 'ESTADO DE VIAJE' AND ctlg_estadoRegistro = 'A'").order(:id)
      #@estadosViaje = @estadosViaje.map{|h| [h.ctlg_valorCdg, h.ctlg_valorDesc]}
      registros = {}
      @estadosViaje.each do |h|
        registros[h.ctlg_valorCdg] = h.ctlg_valorDesc
      end
      
      @estadosViaje = registros
            
      instSQL_select = "vehiculos.id, Concat( IfNull(Concat(C.ctlg_subcategoria
                                              ,'|' 
                                              ,E.empr_nombreCorto
                                              ,' - '
                                              , Trim(SubStr(  S.sucEmpr_nombreSucursal
                                                                , 1
                                                                , InStr(S.sucEmpr_nombreSucursal, '-') -1
                                                               )
                                                     )
                                              )
                                        , Concat( C.ctlg_subcategoria
                                                  ,'|' 
                                                  ,CASE InStr(P.Pers_Nombres, ' ')
                                                    WHEN 0 THEN
                                                      P.Pers_Nombres
                                                    ELSE
                                                      SubStr(P.Pers_Nombres
                                                             , 1
                                                             , InStr(P.Pers_Nombres, ' ') - 1)
                                                 END                                                             
                                                  ,' '
                                                  ,CASE InStr(P.Pers_Apellidos, ' ') 
                                                      WHEN 0 THEN
                                                        P.Pers_Apellidos
                                                      ELSE
                                                        SubStr( P.Pers_Apellidos
                                                               , 1
                                                               , InStr(P.Pers_Apellidos, ' ') - 1)
                                                      END
                                                 )
                                       )
                               , ', '
                               , vehiculos.vehi_modeloCodigo
                               ,' => '
                               , LPad(vehiculos.vehi_capacPasajeros, 2, 0)
                               , ' PAX') vehi_modeloCodigo"
      
      instSQL_joins = "LEFT OUTER JOIN empresas E 
                         ON vehiculos.vehi_propietarioId = E.empr_documentoIdentidad
                       LEFT OUTER JOIN personas P
                         ON vehiculos.vehi_propietarioId = P.pers_documentoIdentidad
                       LEFT OUTER JOIN sucursal_empresas S 
                         ON (E.empr_documentoIdentidad = S.empr_documentoIdentidad AND vehiculos.vehi_sucursalEmpresaPropId = S.id)
                      INNER JOIN catalogos C
                         ON C.ctlg_valorCdg = vehiculos.vehi_tipo
                      WHERE C.ctlg_categoria = 'TIPO DE VEHICULO'
                        AND vehiculos.vehi_estadoRegistro = 'A'"
      
      @vehiculos = Vehiculo.select(instSQL_select).joins(instSQL_joins)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def viaje_params
      params.require(:viaje).permit(:viaje_ruta, :viaje_fecha, :viaje_horaSalida, :viaje_trayecto, :viaje_estado, :vehiculo_id, :viaje_estadoRegistro)
    end
end