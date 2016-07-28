class PersonasController < ApplicationController
  include PersonasHelper
  include EmpresasHelper
  include EntidadTerritorialsHelper
  
  before_action :set_persona, only: [:show, :edit, :update, :destroy]
  before_action :initialize_vars_global, only: [:index, :new, :show, :edit]
  before_action :initialize_vars, only: [:new, :edit, :show]
  
  # GET /personas
  # GET /personas.json
  def index
    @personas = Persona.all
  end

  # GET /personas/1
  # GET /personas/1.json
  def show
    @ciudadDomicilio = @ciudadesColombia.select{|h| h.id == @persona.pers_ciudadDomicilio}.map{|j| j.enter_nombreCorto}.pop
  end

  # GET /personas/new
  def new
    @titulo = "Registrar Persona"
    @persona = Persona.new
  end

  # GET /personas/1/edit
  def edit
    @titulo = "Modificar Persona"
  end

  # POST /personas
  # POST /personas.json
  def create
    @persona = Persona.new(persona_params)

    respond_to do |format|
      if @persona.save
        format.html { redirect_to @persona, notice: 'Persona creada exitosamente.' }
        format.json { render :show, status: :created, location: @persona }
      else
        format.html { render :new }
        format.json { render json: @persona.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /personas/1
  # PATCH/PUT /personas/1.json
  def update
    respond_to do |format|
      if @persona.update(persona_params)
        format.html { redirect_to @persona, notice: 'Persona actualizada exitosamente.' }
        format.json { render :show, status: :ok, location: @persona }
      else
        format.html { render :edit }
        format.json { render json: @persona.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /personas/1
  # DELETE /personas/1.json
  def destroy
    @persona.destroy
    respond_to do |format|
      format.html { redirect_to personas_url, notice: 'Persona eliminada exitosamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_persona
      @persona = Persona.find(params[:id])
    end
    
    def initialize_vars
      @tiposIdentPersona = set_tipos_id_persona
      @tiposIdentEmpresa = set_tipos_id_empresa
      @generos = set_generos_persona
      @estadosCiviles = set_estados_civiles
      @perfilesLaborales = set_perfiles_laborales
      @ciudadesColombia = set_ciudades_colombia
      @paises = set_paises
      
      if params[:action] == "edit" || params[:action] == "show" then 
        
        @sucursal = @persona.sucursalEmpresaId
        @empresa = nil
        @sucursales = nil
        
        unless @sucursal.nil?
          @sucursal = SucursalEmpresa.find(@persona.sucursalEmpresaId)
          @empresa = Empresa.where(empr_documentoIdentidad: @sucursal.empr_documentoIdentidad).take
          @sucursales = set_sucursales_empresa(@empresa.empr_documentoIdentidad)
          @sucursales = @sucursales.map{|h| [h.sucEmpr_nombreSucursal, h.id]}.to_h
        end
        

      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def persona_params
      params.require(:persona).permit(:pers_documentoIdentidad, :pers_nombres, :pers_apellidos, :pers_alias, :pers_sexo, :pers_pesoCorporal, :pers_paisOrigen, :pers_fechaNacimiento, :pers_estadoCivil, :pers_direccionDomicilio, :pers_ciudadDomicilio, :pers_telefonoPersonal1, :pers_telefonoPersonal2, :pers_correoElectrPersonal, :pers_correoElectrLaboral, :pers_perfilLaboral, :sucursalEmpresaId, :empresaCargo, :pers_telefonoLaboral1, :pers_telefonoLaboral2, :pers_estadoRegistro)
    end
end
