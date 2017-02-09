include PersonasHelper
include EmpresasHelper
include ReservasHelper
  
class ReservasController < ApplicationController
  before_action :set_reserva, only: [:show, :edit, :update, :destroy]
  before_action :initialize_vars_global, only: [:index, :new, :show, :edit]
  before_action :initialize_vars, only: [:new, :edit, :show, :index]
  
  # GET /reservas
  # GET /reservas.json
  def index
    @reservas = nil
    pers_documentoIdentidad = params[:nroDocumIdentificacion].to_s + params[:tipoIdentificacion].to_s
    if params.length > 2 then
      @reservas = reservas_buscar(pers_documentoIdentidad, params[:pers_apellidos], params[:pers_nombres], params[:rsrv_codigo], params[:viaje_fechaIni], params[:viaje_fechaFin], params[:vendedor])
    end
  end

  # GET /reservas/1
  # GET /reservas/1.json
  def show
    @producto = "DATOS DEL " + @reserva.rsrv_tipoProducto
    @contacto = Persona.where(pers_documentoIdentidad: @reserva.rsrv_contactoId).take
    @reserva.rsrv_solicitanteId == nil ? @solicitante = @contacto : @solicitante = Persona.where(pers_documentoIdentidad: @reserva.rsrv_solicitanteId).take
    @reservas = reservas_buscar("","","", codigoReserva = @reserva.rsrv_codigo, "", "", "")
    arrCiudad = @reserva.rsrv_trayectoViaje.split("|")
    @enterOrigen = EntidadTerritorial.find(arrCiudad[0])
    @enterDestino = EntidadTerritorial.find(arrCiudad[1])
  end

  # GET /reservas/new
  def new
    @reserva = Reserva.new
  end

  # GET /reservas/1/edit
  def edit
  end

  # POST /reservas
  # POST /reservas.json
  def create
    @reserva = Reserva.new(reserva_params)

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
