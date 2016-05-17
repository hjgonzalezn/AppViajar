class SucursalEmpresasController < ApplicationController
  include EntidadTerritorialsHelper
  include EmpresasHelper
  include PersonasHelper
  include SucursalEmpresasHelper
  
  before_action :initialize_vars_global, only: [:index, :new, :show, :edit]
  before_action :initialize_vars, only: [:new, :edit, :update, :create, :index, :show]
  before_action :set_sucursal_empresa, only: [:show, :edit, :update, :destroy]

  # GET /sucursal_empresas
  # GET /sucursal_empresas.json
  def index
    @sucursal_empresas = SucursalEmpresa.all
  end

  # GET /sucursal_empresas/1
  # GET /sucursal_empresas/1.json
  def show
    @empresa = Empresa.where(empr_documentoIdentidad: @sucursal_empresa.empr_documentoIdentidad).take
  end

  # GET /sucursal_empresas/new
  def new
    @titulo = "Nueva sucursal de empresa"
    @sucursal_empresa = SucursalEmpresa.new
  end

  # GET /sucursal_empresas/1/edit
  def edit
    @titulo = "Modificar sucursal de empresa"
    @parentalPath = set_parental_path(@sucursal_empresa.sucEmpr_ciudadDomicilio, true)
    @empresa = Empresa.where(empr_documentoIdentidad: @sucursal_empresa.empr_documentoIdentidad).take
  end

  # POST /sucursal_empresas
  # POST /sucursal_empresas.json
  def create
    @sucursal_empresa = SucursalEmpresa.new(sucursal_empresa_params)

    respond_to do |format|
      if @sucursal_empresa.save
        format.html { redirect_to @sucursal_empresa, notice: 'Sucursal Empresa creada exitosamente.' }
        format.json { render :show, status: :created, location: @sucursal_empresa }
      else
        format.html { render :new }
        format.json { render json: @sucursal_empresa.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sucursal_empresas/1
  # PATCH/PUT /sucursal_empresas/1.json
  def update
    respond_to do |format|
      if @sucursal_empresa.update(sucursal_empresa_params)
        format.html { redirect_to @sucursal_empresa, notice: 'Sucursal Empresa actualizada exitosamente.' }
        format.json { render :show, status: :ok, location: @sucursal_empresa }
      else
        format.html { render :edit }
        format.json { render json: @sucursal_empresa.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sucursal_empresas/1
  # DELETE /sucursal_empresas/1.json
  def destroy
    @sucursal_empresa.destroy
    respond_to do |format|
      format.html { redirect_to sucursal_empresas_url, notice: 'Sucursal Empresa eliminada exitosamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sucursal_empresa
      @sucursal_empresa = SucursalEmpresa.find(params[:id])
    end
    
    def initialize_vars
      @continentes = set_continentes
      @tiposIdentEmpresa = set_tipos_id_empresa
      @tiposSucursal = set_tipos_sucursal
      @tiposIdentPersona = set_tipos_id_persona
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def sucursal_empresa_params
      params.require(:sucursal_empresa).permit(:empr_documentoIdentidad, :sucEmpr_ciudadDomicilio,:sucEmpr_nombreSucursal, :sucEmpr_direccion, :sucEmpr_telefono1, :sucEmpr_telefono2, :sucEmpr_correoElectronico, :sucEmpr_docIdentContacto1, :sucEmpr_docIdentContacto2, :sucEmpr_TipoSucursal, :sucEmpr_horarioAtencion, :sucEmp_estadoRegistro)
    end
end
