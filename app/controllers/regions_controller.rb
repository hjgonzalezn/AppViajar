class RegionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_region, only: [:show, :edit, :update, :destroy]
  before_action :initialize_vars_global, only: [:index, :new, :show, :edit]
  before_action :initialize_vars, only: [:new, :edit]
  
  # GET /regions
  # GET /regions.json
  def index
    @regions = Region.all.order(:reg_nombre)
    idEntidades = ""
    @regions.each do |h|
      idEntidades = idEntidades + h.reg_entidad_territorial_id.to_s + ","
    end
    
    idEntidades = idEntidades[0, idEntidades.length - 1]
    @entidadesTerritoriales = EntidadTerritorial.where("id IN (#{idEntidades})")
    
  end

  # GET /regions/1
  # GET /regions/1.json
  def show
    @entidadTerritorial=EntidadTerritorial.find(@region.reg_entidad_territorial_id)
  end

  # GET /regions/new
  def new
    @titulo = "Nueva region"
    @region = Region.new
  end

  # GET /regions/1/edit
  def edit
    @titulo = "Modificar region"
  end

  # POST /regions
  # POST /regions.json
  def create
    @region = Region.new(region_params)

    respond_to do |format|
      if @region.save
        format.html { redirect_to @region, notice: 'Region creada exitosamente.' }
        format.json { render :show, status: :created, location: @region }
      else
        format.html { render :new }
        format.json { render json: @region.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /regions/1
  # PATCH/PUT /regions/1.json
  def update
    respond_to do |format|
      if @region.update(region_params)
        format.html { redirect_to @region, notice: 'Region actualizada exitosamente.' }
        format.json { render :show, status: :ok, location: @region }
      else
        format.html { render :edit }
        format.json { render json: @region.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /regions/1
  # DELETE /regions/1.json
  def destroy
    @region.destroy
    respond_to do |format|
      format.html { redirect_to regions_url, notice: 'Region eliminada exitosamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_region
      @region = Region.find(params[:id])
    end
    
    def initialize_vars
      @padreRegion = EntidadTerritorial.where("enter_nivel IN (1,2) AND enter_estadoRegistro = 'A'")
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def region_params
      params.require(:region).permit(:reg_nombre, :reg_presentacion, :reg_entidad_territorial_id, :reg_estadoRegistro)
    end
end
