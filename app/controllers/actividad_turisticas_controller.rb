class ActividadTuristicasController < ApplicationController
  before_action :authenticate_user!
  before_action :set_actividad_turistica, only: [:show, :edit, :update, :destroy]
  before_action :initialize_vars_global, only: [:index, :new, :show, :edit]
  before_action :initialize_vars, only: [:new, :edit, :show, :update]
    
  # GET /actividad_turisticas
  # GET /actividad_turisticas.json
  def index
    @actividad_turisticas = ActividadTuristica.all
  end

  # GET /actividad_turisticas/1
  # GET /actividad_turisticas/1.json
  def show
  end

  # GET /actividad_turisticas/new
  def new
    @titulo = "Nueva actividad turistica"
    @actividad_turistica = ActividadTuristica.new
  end

  # GET /actividad_turisticas/1/edit
  def edit
    @titulo = "Modificar actividad turistica"
  end

  # POST /actividad_turisticas
  # POST /actividad_turisticas.json
  def create
    @actividad_turistica = ActividadTuristica.new(actividad_turistica_params)
    
    respond_to do |format|
      if @actividad_turistica.save
        fecha = Date.new
        @tarifa = Tarifa.new
        @tarifa.trf_concepto = "VALOR ACTIVIDAD TURISTICA"
        @tarifa.trf_conceptoCodigo = "VACTUR"
        @tarifa.trf_conceptoAplicacion = "SALIDA"
        @tarifa.trf_naturaleza = "CR"
        @tarifa.trf_tipoProducto = "ACTIVIDAD_TURISTICAS"
        @tarifa.trf_producto = @actividad_turistica.id 
        @tarifa.trf_unidadCobro = "PERSONA"
        @tarifa.trf_fechaInicio = fecha.strftime('y%-m%-d')
        @tarifa.trf_estadoRegistro = "A"
        @tarifa.trf_base = params[:tarifa][:trf_base]
        @tarifa.save
        
        format.html { redirect_to @actividad_turistica, notice: 'Actividad turistica registrada exitosamente.' }
        format.json { render :show, status: :created, location: @actividad_turistica }
      else
        format.html { render :new }
        format.json { render json: @actividad_turistica.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /actividad_turisticas/1
  # PATCH/PUT /actividad_turisticas/1.json
  def update
    respond_to do |format|
      if @actividad_turistica.update(actividad_turistica_params)
        if @tarifa.nil?
          fecha = Date.new
          @tarifa = Tarifa.new
          @tarifa.trf_concepto = "VALOR ACTIVIDAD TURISTICA"
          @tarifa.trf_conceptoCodigo = "VACTUR"
          @tarifa.trf_conceptoAplicacion = "SALIDA"
          @tarifa.trf_naturaleza = "CR"
          @tarifa.trf_tipoProducto = "ACTIVIDAD_TURISTICAS"
          @tarifa.trf_producto = @actividad_turistica.id 
          @tarifa.trf_unidadCobro = "PERSONA"
          @tarifa.trf_fechaInicio = fecha.strftime('y%-m%-d')
          @tarifa.trf_estadoRegistro = "A"
          @tarifa.trf_base = params[:tarifa][:trf_base]
        else
          @tarifa.trf_base = params[:tarifa][:trf_base]
        end
        @tarifa.save
        format.html { redirect_to @actividad_turistica, notice: 'Actividad turistica actualizada exitosamente.' }
        format.json { render :show, status: :ok, location: @actividad_turistica }
      else
        format.html { render :edit }
        format.json { render json: @actividad_turistica.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /actividad_turisticas/1
  # DELETE /actividad_turisticas/1.json
  def destroy
    @actividad_turistica.destroy
    respond_to do |format|
      format.html { redirect_to actividad_turisticas_url, notice: 'Actividad turistica eliminada exitosamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_actividad_turistica
      @actividad_turistica = ActividadTuristica.find(params[:id])
    end
    
    def initialize_vars
      @tiposActividadTuristicas = TipoActividadTuristica.select("id, tiAcT_nombre").where("tiAcT_estadoRegistro = 'A'")
      unless @actividad_turistica.nil?
        @tarifa = Tarifa.where("trf_tipoProducto = 'ACTIVIDAD_TURISTICAS' AND trf_producto = ? AND trf_estadoRegistro = 'A'", @actividad_turistica.id.to_s).take
      end
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def actividad_turistica_params
      params.require(:actividad_turistica).permit(:actur_descripcion, :tipo_actividad_turistica_id, :actur_estadoRegistro)
    end
end
