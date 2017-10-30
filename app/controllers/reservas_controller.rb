class ReservasController < ApplicationController
  include PersonasHelper
  include EmpresasHelper
  include ReservasHelper
  include ActividadTuristicasHelper
  
  before_action :authenticate_user!
  after_action :verify_authorized
  before_action :set_reserva, only: [:show, :edit, :update, :destroy]
  before_action :initialize_vars_global, only: [:index, :new, :show, :edit]
  before_action :initialize_vars, only: [:new, :edit, :show, :index]
  
  # GET /reservas
  # GET /reservas.json
  def index
    authorize Reserva
    @reservas = nil
    pers_documentoIdentidad = params[:nroDocumIdentificacion].to_s + params[:tipoIdentificacion].to_s
    if params.length > 2 then
      @reservas = reservas_buscar(pers_documentoIdentidad, params[:pers_apellidos], params[:pers_nombres], params[:rsrv_codigo], params[:viaje_fechaIni], params[:viaje_fechaFin], params[:vendedor])
    end
  end

  # GET /reservas/1
  # GET /reservas/1.json
  def show
    authorize @reserva
    if @reserva.rsrv_tipoProducto == "VUELO" then
      @producto = "DATOS DEL " + @reserva.rsrv_tipoProducto
    elsif @reserva.rsrv_tipoProducto == "PLAN" then
      paquete = PaqueteTuristico.find(@reserva.rsrv_productoId)
      @producto = @reserva.rsrv_tipoProducto + " " + paquete.pqTur_nombre
    end
    
    @contacto = Persona.where(pers_documentoIdentidad: @reserva.rsrv_contactoId).take
    @reserva.rsrv_solicitanteId == nil ? @solicitante = @contacto : @solicitante = Persona.where(pers_documentoIdentidad: @reserva.rsrv_solicitanteId).take
    @reservas = reservas_buscar("","","", codigoReserva = @reserva.rsrv_codigo, "", "", "")
    @servOpcReserva = set_actividades_reserva(@reserva.id)
    @valorTotalReserva = reserva_calcular_tarifa(@reserva.rsrv_codigo)
    @pagos = Pago.select("pago_fecha, pago_forma, pago_valor, pago_estado, pago_transaccion").where("pago_tipoProducto = 'RESERVA' AND pago_productoId = ? AND pago_estadoRegistro = 'A'", @reserva.rsrv_codigo)
    arrCiudad = @reserva.rsrv_trayectoViaje.split("|")
    @enterOrigen = EntidadTerritorial.find(arrCiudad[0])
    @enterDestino = EntidadTerritorial.find(arrCiudad[1])
  end

  # GET /reservas/new
  def new
    @titulo = "Nueva reserva"
    @reserva = Reserva.new
    authorize @reserva
  end

  # GET /reservas/1/edit
  def edit
    @titulo = "Modificar reserva"
    authorize @reserva
  end

  # POST /reservas
  # POST /reservas.json
  def create
    @reserva = Reserva.new(reserva_params)
    authorize @reserva
    respond_to do |format|
      if @reserva.save
        format.html { redirect_to @reserva, notice: 'Reserva creada exitosamente.' }
        format.json { render :show, status: :created, location: @reserva }
      else
        format.html { render :new }
        format.json { render json: @reserva.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reservas/1
  # PATCH/PUT /reservas/1.json
  def update
    authorize Reserva
    respond_to do |format|
      if @reserva.update(reserva_params)
        format.html { redirect_to @reserva, notice: 'Reserva actualizada exitosamente.' }
        format.json { render :show, status: :ok, location: @reserva }
      else
        format.html { render :edit }
        format.json { render json: @reserva.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservas/1
  # DELETE /reservas/1.json
  def destroy
    authorize @reserva
    @reserva.destroy
    respond_to do |format|
      format.html { redirect_to reservas_url, notice: 'Reserva eliminada exitosamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reserva
      @reserva = Reserva.find(params[:id])
    end

    def initialize_vars
      @tiposIdentPersona = set_tipos_id_persona
      @tiposIdentEmpresa = set_tipos_id_empresa
      estados = Catalogo.where("ctlg_categoria = 'ESTADO DE RESERVA' AND ctlg_estadoRegistro = 'A'")
      @hshEstadosReserva = Hash.new
      estados.each do |h|
        @hshEstadosReserva[h.ctlg_valorCdg] = h.ctlg_valorDesc 
      end
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def reserva_params
      params.require(:reserva).permit(:rsrv_codigo, :rsrv_tipoProducto, :rsrv_productoId, :rsrv_tipoSolicitante, :rsrv_solicitanteId, :rsrv_tipoContacto, :rsrv_contactoId, :rsrv_estadoReserva, :rsrv_estadoRegistro, :rsrv_fechaVencimiento, :created_by, :updated_by)
    end
end
