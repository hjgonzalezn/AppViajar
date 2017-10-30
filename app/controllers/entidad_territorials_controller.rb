class EntidadTerritorialsController < ApplicationController
  include EntidadTerritorialsHelper
  before_action :authenticate_user!
  before_action :set_entidad_territorial, only: [:show, :edit, :update, :destroy]
  before_action :initialize_vars_global, only: [:index, :new, :show, :edit]
  before_action :initialize_vars, only: [:new, :edit, :update, :create, :index, :show]
  
 # GET /entidad_territorials
  # GET /entidad_territorials.json
  def index
    @entidad_territorials = EntidadTerritorial.all
  end

  # GET /entidad_territorials/1
  # GET /entidad_territorials/1.json
  def show
    @entidad_territorials = EntidadTerritorial.all
  end

  # GET /entidad_territorials/new
  def new
    @titulo = "Nueva Entidad Territorial"
    # Nivel de la entidad territorial
    @enter_nivel = 1
    @padreId = 1
    @entidad_territorial = EntidadTerritorial.new
    # Unidad territorial 9 - CONTINENTE por default
    @unidadesTerritoriales = @unidadesTerritoriales.select{|h| h.id == 9}.map{|reg| [reg.undter_nombre, reg.id]}.to_h
  end

  # GET /entidad_territorials/1/edit
  def edit
    @titulo = "Modificar Territorial"
    # Nivel de la entidad territorial para View
    @enter_nivel = @entidad_territorial.enter_nivel
    @unidadTerritAct = @entidad_territorial.division_pais_id
    @parentalPath = set_parental_path(@entidad_territorial.id)
    @padreId = @entidad_territorial.enter_padreId
        
    if @enter_nivel >= 2 then
      @enter_pais = set_pais(@entidad_territorial.id)
      @enter_id = @enter_pais.id
      @unidadesTerritoriales = UnidadTerritorial.select("id codigo, undter_nombre descripcion").where("id IN (SELECT unidad_territorial_id FROM division_pais WHERE entidad_territorial_id = #{@enter_id} AND divpais_nivel = '#{@enter_nivel}' AND divpais_estadoRegistro = 'A')")
      @unidadesTerritoriales = @unidadesTerritoriales.map{|reg| [reg.descripcion, reg.codigo]}.to_h
    elsif @enter_nivel == 1 then
      @enter_id = @entidad_territorial.id
      @unidadesTerritoriales = @unidadesTerritoriales.select{|h| h.id == 9}.map{|reg| [reg.undter_nombre, reg.id]}.to_h
    end
    
    @arrRegiones = Region.where(reg_entidad_territorial_id: @enter_id)
    
    unless @arrRegiones.nil?
      @regiones = @arrRegiones.map{|h| [h.reg_nombre, h.id]}.to_h
    end
    
  end

  # POST /entidad_territorials
  # POST /entidad_territorials.json
  def create
    @entidad_territorial = EntidadTerritorial.new(entidad_territorial_params)

    respond_to do |format|
      if @entidad_territorial.save
        format.html { redirect_to @entidad_territorial, notice: 'Entidad territorial creada exitosamente.' }
        format.json { render :show, status: :created, location: @entidad_territorial }
      else
        format.html { render :new }
        format.json { render json: @entidad_territorial.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /entidad_territorials/1
  # PATCH/PUT /entidad_territorials/1.json
  def update
    respond_to do |format|
      if @entidad_territorial.update(entidad_territorial_params)
        format.html { redirect_to @entidad_territorial, notice: 'Entidad territorial actualizada exitosamente.' }
        format.json { render :show, status: :ok, location: @entidad_territorial }
      else
        format.html { render :edit }
        format.json { render json: @entidad_territorial.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entidad_territorials/1
  # DELETE /entidad_territorials/1.json
  def destroy
    @entidad_territorial.destroy
    respond_to do |format|
      format.html { redirect_to entidad_territorials_url, notice: 'Entidad territorial eliminada exitosamente.' }
      format.json { head :no_content }
    end
  end

  private
  
    # Use callbacks to share common setup or constraints between actions.
    def set_entidad_territorial
      @entidad_territorial = EntidadTerritorial.find(params[:id])
    end
    
    def initialize_vars
      # Carga unidades territoriales activas
      @unidadesTerritoriales = UnidadTerritorial.where("undter_estadoRegistro = 'A'").order(:undter_nombre)
      @hshUnidadesTer = @unidadesTerritoriales.map{|h| [h.id, h.undter_nombre]}.to_h
      # Carga los continentes
      @continentes = set_continentes
      # Carga la división territorial de un país, continente, etc.
      @division_pais = DivisionPai.where(divpais_estadoRegistro: :A)
      # Inicializando regiones
      @regiones = [["-- SELECCIONE --", ""]]
      @parentalPath = ""
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def entidad_territorial_params
      params.require(:entidad_territorial).permit(:enter_nombreOficial, :enter_nombreCorto, :enter_codigoOficial, :enter_presentacion, :enter_padreId, :enter_nivel, :region_id, :division_pais_id, :enter_estadoRegistro)
    end
end
