class PagosController < ApplicationController
  include ApplicationHelper
  include ReservasHelper

  before_action :authenticate_user!  
  before_action :set_pago, only: [:show, :edit, :update, :destroy]
  before_action :initialize_vars_global, only: [:index, :new, :show, :edit]
  before_action :initialize_vars, only: [:new, :edit, :show]
  
  # GET /pagos
  # GET /pagos.json
  def index
    @pagos = Pago.all
  end

  # GET /pagos/1
  # GET /pagos/1.json
  def show
  end

  # GET /pagos/new
  def new
    @pago = Pago.new
    @titulo = "Nuevo pago"
    arrProducto = params[:datos].split("|")
    @pago.pago_tipoProducto = arrProducto[0]
    @pago.pago_productoId = arrProducto[1]
    @pago_valorPendiente = reserva_calcular_tarifa(arrProducto[1])
    @parentPath = set_parent_path
  end

  # GET /pagos/1/edit
  def edit
    @titulo = "Modificar pago"
  end

  # POST /pagos
  # POST /pagos.json
  def create
    @pago = Pago.new(pago_params)
    @pagoPendAplicar = @pago.pago_valor
    case @pago.pago_tipoProducto
      when "RESERVA"
        reserva = Reserva.where("rsrv_codigo = '#{@pago.pago_productoId}'").take
        detallesReserva = DetalleReserva.where("reserva_id = ? AND detRsrv_estadoReserva = 'P'" ,reserva.id)
        @parentPath = "/reservas/" + reserva.id.to_s
        if reserva.rsrv_tipoProducto == "VUELO" then
          tarifasViaje = tarifas_viaje(@pago.pago_productoId)
          if tarifasViaje.viaje_tarifas.nil?
            detallesReserva.each do |h|
              if @pagoPendAplicar > 0 then
                h.detRsrv_tarifaCodigo = "BASE"
                h.detRsrv_estadoReserva = "C"
                if @pagoPendAplicar > tarifasViaje.trf_base then
                  h.detRsrv_valor = tarifasViaje.trf_base 
                  @pagoPendAplicar = @pagoPendAplicar - tarifasViaje.trf_base
                else
                   h.detRsrv_valor = @pagoPendAplicar
                   @pagoPendAplicar = 0
                end
              end
              h.save
            end
          else
          end
         end   
        reserva.rsrv_estadoReserva = "C"
        reserva.save
    end

    respond_to do |format|
      if @pago.save
        format.html { redirect_to @parentPath, notice: 'Pago creado exitosamente.' }
        format.json { render :show, status: :created, location: @pago }
      else
        format.html { render :new }
        format.json { render json: @pago.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pagos/1
  # PATCH/PUT /pagos/1.json
  def update
    respond_to do |format|
      if @pago.update(pago_params)
        format.html { redirect_to @pago, notice: 'Pago actualizado exitosamente.' }
        format.json { render :show, status: :ok, location: @pago }
      else
        format.html { render :edit }
        format.json { render json: @pago.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pagos/1
  # DELETE /pagos/1.json
  def destroy
    @pago.destroy
    respond_to do |format|
      format.html { redirect_to pagos_url, notice: 'Pago eliminado exitosamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pago
      @pago = Pago.find(params[:id])
    end
    
    def set_parent_path
      @ruta = request.fullpath
      @ruta = @ruta.split("/")
     
      if @ruta.length > 2 then        
        @parentController = @ruta[1]
        @parentId = @ruta[2]
        parent_path = "/" + @parentController + "/" + @parentId
      end
      
      return parent_path
    end
    
    def initialize_vars
      @arrDatosPago = Catalogo.select("id, ctlg_valorCdg, ctlg_valorDesc, ctlg_categoria, ctlg_subcategoria, ctlg_observacion").where("ctlg_categoria IN ('FORMA DE PAGO', 'ESTADO DE PAGO', 'CANAL RECAUDO') AND ctlg_estadoRegistro = 'A'")
      @hshFormasDePago = @arrDatosPago.select{|t| t.ctlg_categoria == "FORMA DE PAGO"}.map{|h| [h.ctlg_valorDesc, h.ctlg_valorCdg]}
      @hshEstadosDePago = @arrDatosPago.select{|t| t.ctlg_categoria == "ESTADO DE PAGO"}.map{|h| [h.ctlg_valorDesc, h.ctlg_valorCdg]}
      @hshCtaBancarias = @arrDatosPago.select{|t| t.ctlg_categoria == "CANAL RECAUDO"}.map{|h| [h.ctlg_subcategoria + " - " + h.ctlg_observacion + " - " + h.ctlg_valorDesc, h.id]}
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pago_params
      params.require(:pago).permit(:pago_tipoProducto, :pago_productoId, :pago_valor, :pago_forma, :pago_ctaBancDestino, :pago_fecha, :pago_entidad, :dtpag_sucursalId, :pago_transaccion, :pago_estado, :pago_estadoRegistro, :created_by, :updated_by)
    end
end
