class AccionsController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized, except: [:index]
  before_action :set_accion, only: [:show, :edit, :update, :destroy]
  before_action :initialize_vars_global, only: [:index, :new, :show, :edit]
  before_action :initialize_vars, only: [:new, :edit, :show]

  # GET /accions
  # GET /accions.json
  def index
    @accions = Accion.all
    authorize Accion
  end

  # GET /accions/1
  # GET /accions/1.json
  def show
    authorize @accion
  end

  # GET /accions/new
  def new
    @accion = Accion.new
    authorize @accion
    @titulo = "Nueva Acción"
  end

  # GET /accions/1/edit
  def edit
    authorize @accion
    @titulo = "Modificar Acción"
  end

  # POST /accions
  # POST /accions.json
  def create
    authorize @accion
    @accion = Accion.new(accion_params)

    respond_to do |format|
      if @accion.save
        format.html { redirect_to @accion, notice: 'Acción creada exitosamente.' }
        format.json { render :show, status: :created, location: @accion }
      else
        format.html { render :new }
        format.json { render json: @accion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accions/1
  # PATCH/PUT /accions/1.json
  def update
    authorize @accion
    respond_to do |format|
      if @accion.update(accion_params)
        format.html { redirect_to @accion, notice: 'Accion actualizada exitosamente.' }
        format.json { render :show, status: :ok, location: @accion }
      else
        format.html { render :edit }
        format.json { render json: @accion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accions/1
  # DELETE /accions/1.json
  def destroy
    authorize @accion
    @accion.destroy
    respond_to do |format|
      format.html { redirect_to accions_url, notice: 'Accion eliminada exitosamente.' }
      format.json { head :no_content }
    end
  end

  private
  
    def initialize_vars
    end
    
    # Use callbacks to share common setup or constraints between actions.
    def set_accion
      @accion = Accion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def accion_params
      params.require(:accion).permit(:acc_codigo, :acc_nombre, :acc_estadoRegistro)
    end
end
