class TipoActividadTuristicasController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tipo_actividad_turistica, only: [:show, :edit, :update, :destroy]
  before_action :initialize_vars_global, only: [:index, :new, :show, :edit]
  before_action :initialize_vars, only: [:new, :edit, :show]
  
  # GET /tipo_actividad_turisticas
  # GET /tipo_actividad_turisticas.json
  def index
    @tipo_actividad_turisticas = TipoActividadTuristica.all
  end

  # GET /tipo_actividad_turisticas/1
  # GET /tipo_actividad_turisticas/1.json
  def show
  end

  # GET /tipo_actividad_turisticas/new
  def new
    @titulo = "Nuevo tipo de actividad turística"
    @tipo_actividad_turistica = TipoActividadTuristica.new
  end

  # GET /tipo_actividad_turisticas/1/edit
  def edit
    @titulo = "Modificar tipo de actividad turística"
  end

  # POST /tipo_actividad_turisticas
  # POST /tipo_actividad_turisticas.json
  def create
    @tipo_actividad_turistica = TipoActividadTuristica.new(tipo_actividad_turistica_params)

    respond_to do |format|
      if @tipo_actividad_turistica.save
        format.html { redirect_to @tipo_actividad_turistica, notice: 'Tipo actividad turistica creada exitosamente.' }
        format.json { render :show, status: :created, location: @tipo_actividad_turistica }
      else
        format.html { render :new }
        format.json { render json: @tipo_actividad_turistica.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tipo_actividad_turisticas/1
  # PATCH/PUT /tipo_actividad_turisticas/1.json
  def update
    respond_to do |format|
      if @tipo_actividad_turistica.update(tipo_actividad_turistica_params)
        format.html { redirect_to @tipo_actividad_turistica, notice: 'Tipo actividad turistica actualizada exitosamente.' }
        format.json { render :show, status: :ok, location: @tipo_actividad_turistica }
      else
        format.html { render :edit }
        format.json { render json: @tipo_actividad_turistica.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tipo_actividad_turisticas/1
  # DELETE /tipo_actividad_turisticas/1.json
  def destroy
    @tipo_actividad_turistica.destroy
    respond_to do |format|
      format.html { redirect_to tipo_actividad_turisticas_url, notice: 'Tipo actividad turistica eliminada exitosamente.' }
      format.json { head :no_content }
    end
  end
  
  def initialize_vars
    
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tipo_actividad_turistica
      @tipo_actividad_turistica = TipoActividadTuristica.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tipo_actividad_turistica_params
      params.require(:tipo_actividad_turistica).permit(:tiAcT_nombre, :tiAcT_descripcion, :tiAcT_foto, :tiAcT_icono, :tiAcT_visibilidad, :tiAcT_estadoRegistro)
    end
end
