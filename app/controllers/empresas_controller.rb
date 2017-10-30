class EmpresasController < ApplicationController
  include EmpresasHelper
  
  before_action :authenticate_user!
  before_action :set_empresa, only: [:show, :edit, :update, :destroy]
  before_action :initialize_vars_global, only: [:index, :new, :show, :edit]
  before_action :initialize_vars, only: [:new, :edit, :show, :index]
  
  # GET /empresas
  # GET /empresas.json
  def index
    @empresas = Empresa.all
  end

  # GET /empresas/1
  # GET /empresas/1.json
  def show
  end

  # GET /empresas/new
  def new
    @titulo = "Nueva Empresa"
    @empresa = Empresa.new
    @empr_numeroIdentidad = nil
  end

  # GET /empresas/1/edit
  def edit
    @titulo = "Modificar Empresa"
    @empr_numeroIdentidad = @empresa.empr_documentoIdentidad[0,@empresa.empr_documentoIdentidad.length - 2]
  end

  # POST /empresas
  # POST /empresas.json
  def create
    @empresa = Empresa.new(empresa_params)

    respond_to do |format|
      if @empresa.save
        format.html { redirect_to @empresa, notice: 'Empresa creada exitosamente.' }
        format.json { render :show, status: :created, location: @empresa }
      else
        format.html { render :new }
        format.json { render json: @empresa.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /empresas/1
  # PATCH/PUT /empresas/1.json
  def update
    respond_to do |format|
      if @empresa.update(empresa_params)
        format.html { redirect_to @empresa, notice: 'Empresa actualizada exitosamente.' }
        format.json { render :show, status: :ok, location: @empresa }
      else
        format.html { render :edit }
        format.json { render json: @empresa.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /empresas/1
  # DELETE /empresas/1.json
  def destroy
    @empresa.destroy
    respond_to do |format|
      format.html { redirect_to empresas_url, notice: 'Empresa eliminada exitosamente.' }
      format.json { head :no_content }
    end
  end

  private
    
    def initialize_vars
      @tiposEmpresa = Hash.new
      @tiposCapital = Hash.new

      @tiposIdentEmpresa = set_tipos_id_empresa

      # Tipos de Empresa
      Catalogo.where("ctlg_categoria = 'TIPO DE EMPRESA' AND ctlg_estadoRegistro = 'A'").find_each do |h|
        @tiposEmpresa[h.ctlg_valorCdg]= h.ctlg_valorDesc
      end
      
      # Tipos de capital de una empresa 
      Catalogo.where("ctlg_categoria = 'TIPO DE CAPITAL' AND ctlg_estadoRegistro = 'A'").find_each do |h|
        @tiposCapital[h.ctlg_valorCdg]= h.ctlg_valorDesc
      end
    end
    
    # Use callbacks to share common setup or constraints between actions.
    def set_empresa
      @empresa = Empresa.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def empresa_params
      params.require(:empresa).permit(:empr_documentoIdentidad, :empr_razonSocial, :empr_nombreCorto, :empr_tipoEmpresa, :empr_sectorEconomico, :empr_docIdentReprLegal, :empr_sitioWeb, :empr_correoElectronico, :empr_otrosDatos, :empr_estadoRegistro)
    end
end
