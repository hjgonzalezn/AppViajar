class DivisionPaisController < ApplicationController
  before_action :authenticate_user!
  before_action :set_division_pai, only: [:show, :edit, :update, :destroy]
  before_action :initialize_vars_global, only: [:index, :new, :show, :edit]
  before_action :initialize_vars, only: [:index, :new, :edit]
  
  # GET /division_pais
  # GET /division_pais.json
  def index
    @division_pais = DivisionPai.all
  end

  # GET /division_pais/1
  # GET /division_pais/1.json
  def show
  end

  # GET /division_pais/new
  def new
    @titulo = "Nueva División País"
    @division_pai = DivisionPai.new
  end

  # GET /division_pais/1/edit
  def edit
    @titulo = "Modificar División País"
  end

  # POST /division_pais
  # POST /division_pais.json
  def create
    @division_pai = DivisionPai.new(division_pai_params)

    respond_to do |format|
      if @division_pai.save
        format.html { redirect_to @division_pai, notice: 'Division pais creada exitosamente.' }
        format.json { render :show, status: :created, location: @division_pai }
      else
        format.html { render :new }
        format.json { render json: @division_pai.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /division_pais/1
  # PATCH/PUT /division_pais/1.json
  def update
    respond_to do |format|
      if @division_pai.update(division_pai_params)
        format.html { redirect_to @division_pai, notice: 'Division pais actualizada exitosamente.' }
        format.json { render :show, status: :ok, location: @division_pai }
      else
        format.html { render :edit }
        format.json { render json: @division_pai.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /division_pais/1
  # DELETE /division_pais/1.json
  def destroy
    @division_pai.destroy
    respond_to do |format|
      format.html { redirect_to division_pais_url, notice: 'Division pais eliminada exitosamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_division_pai
      @division_pai = DivisionPai.find(params[:id])
    end
    
    def initialize_vars
      @entidadesTerritoriales = EntidadTerritorial.where(enter_estadoRegistro: "A")
      @unidadesTerritoriales = UnidadTerritorial.where(undter_estadoRegistro: "A")
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def division_pai_params
      params.require(:division_pai).permit(:entidad_territorial_id, :unidad_territorial_id, :divpais_nivel, :divpais_estadoRegistro)
    end
end
