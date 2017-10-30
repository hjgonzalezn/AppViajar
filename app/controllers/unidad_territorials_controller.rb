class UnidadTerritorialsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_unidad_territorial, only: [:show, :edit, :update, :destroy]
  before_action :initialize_vars_global, only: [:index, :new, :show, :edit]
  
  # GET /unidad_territorials
  # GET /unidad_territorials.json
  def index
    @unidad_territorials = UnidadTerritorial.all
  end

  # GET /unidad_territorials/1
  # GET /unidad_territorials/1.json
  def show
  end

  # GET /unidad_territorials/new
  def new
    @titulo = "Nueva Unidad Territorial"
    @unidad_territorial = UnidadTerritorial.new
  end

  # GET /unidad_territorials/1/edit
  def edit
     @titulo = "Modificar Unidad Territorial"
  end

  # POST /unidad_territorials
  # POST /unidad_territorials.json
  def create
    @unidad_territorial = UnidadTerritorial.new(unidad_territorial_params)

    respond_to do |format|
      if @unidad_territorial.save
        format.html { redirect_to @unidad_territorial, notice: 'Unidad territorial creada exitosamente.' }
        format.json { render :show, status: :created, location: @unidad_territorial }
      else
        format.html { render :new }
        format.json { render json: @unidad_territorial.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /unidad_territorials/1
  # PATCH/PUT /unidad_territorials/1.json
  def update
    respond_to do |format|
      if @unidad_territorial.update(unidad_territorial_params)
        format.html { redirect_to @unidad_territorial, notice: 'Unidad territorial actualizada exitosamente.' }
        format.json { render :show, status: :ok, location: @unidad_territorial }
      else
        format.html { render :edit }
        format.json { render json: @unidad_territorial.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /unidad_territorials/1
  # DELETE /unidad_territorials/1.json
  def destroy
    @unidad_territorial.destroy
    respond_to do |format|
      format.html { redirect_to unidad_territorials_url, notice: 'Unidad territorial eliminada exitosamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_unidad_territorial
      @unidad_territorial = UnidadTerritorial.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def unidad_territorial_params
      params.require(:unidad_territorial).permit(:undter_nombre, :undter_estadoRegistro)
    end
end
