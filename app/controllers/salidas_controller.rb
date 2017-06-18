include ReservasHelper

class SalidasController < ApplicationController
  before_action :set_salida, only: [:show, :edit, :update, :destroy]
  before_action :initialize_vars_global, only: [:index, :new, :show, :edit]
  before_action :initialize_vars, only: [:index, :new, :edit, :create, :update, :destroy, :show]
  
  # GET /salidas
  # GET /salidas.json
  def index
    @salidas = Salida.all
  end

  # GET /salidas/1
  # GET /salidas/1.json
  def show
    #Estados de una reserva: B - Bloqueada, C - Confirmada, N - Nula, I - Pendiente
    @reservas = reservas_salida_paquete_turistico(@salida.id)
    # @reservas.each do |h|
      # puts h.rsrv_estadoReserva
    # end
    
    @confirmadas = @reservas.select{|h| h.rsrv_estadoReserva == "C" || h.rsrv_estadoReserva == "B"}
    @pendientes = @reservas.select{|h| h.rsrv_estadoReserva == "I"}
    @nulas = @reservas.select{|h| h.rsrv_estadoReserva == "N"}
  end

  # GET /salidas/new
  def new
    @titulo = "Nueva salida"
    @salida = Salida.new
    @salida.paquete_turistico_id = @paqueteTuristico.id
  end

  # GET /salidas/1/edit
  def edit
    @titulo = "Modificar salida"
  end

  # POST /salidas
  # POST /salidas.json
  def create
    @salida = Salida.new(salida_params)
    respond_to do |format|
      if @salida.save
        format.html { redirect_to @parent_path, notice: 'Salida creada exitosamente.' }
        format.json { render :show, status: :created, location: @salida }
      else
        format.html { render :new }
        format.json { render json: @salida.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /salidas/1
  # PATCH/PUT /salidas/1.json
  def update
    respond_to do |format|
      if @salida.update(salida_params)
        format.html { redirect_to @salida, notice: 'Salida actualizada exitosamente.' }
        format.json { render :show, status: :ok, location: @salida }
      else
        format.html { render :edit }
        format.json { render json: @salida.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /salidas/1
  # DELETE /salidas/1.json
  def destroy
    @salida.destroy
    respond_to do |format|
      format.html { redirect_to salidas_url, notice: 'Salida eliminada exitosamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_salida
      @salida = Salida.find(params[:id])
    end
    
    def initialize_vars
      @ruta = request.fullpath
      @ruta = @ruta.split("/")
      
      @parentController = "paquete_turisticos"
      unless params[:salida].nil?
        @parentId = params[:salida][:paquete_turistico_id]
      else
        unless params[:paquete_turistico_id].nil?
          @parentId = params[:paquete_turistico_id]
        else
          @parentId = @salida.paquete_turistico_id.to_s
        end
      end
        
      # if @ruta.length > 2 then        
        # @parentController = @ruta[1]
        # @parentId = @ruta[2]
      # end
      
      @parent_path = "/" + @parentController + "/" + @parentId
      
      @paqueteTuristico = PaqueteTuristico.find(@parentId)
      
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def salida_params
      params.require(:salida).permit(:paquete_turistico_id, :sld_fecha, :sld_estadoRegistro)
    end
end
