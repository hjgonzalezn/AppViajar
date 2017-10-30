class ControlsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_control, only: [:show, :edit, :update, :destroy]
  before_action :initialize_vars_global, only: [:index, :new, :show, :edit]
  before_action :initialize_vars, only: [:new, :edit, :show]
  
  # GET /controls
  # GET /controls.json
  def index
    @controls = Control.all
  end

  # GET /controls/1
  # GET /controls/1.json
  def show
  end

  # GET /controls/new
  def new
    @titulo = "Nuevo control"
    @control = Control.new
  end

  # GET /controls/1/edit
  def edit
    @titulo = "Modificar control"
  end

  # POST /controls
  # POST /controls.json
  def create
    @control = Control.new(control_params)

    respond_to do |format|
      if @control.save
        format.html { redirect_to @control, notice: 'Control creado exitosamente.' }
        format.json { render :show, status: :created, location: @control }
      else
        format.html { render :new }
        format.json { render json: @control.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /controls/1
  # PATCH/PUT /controls/1.json
  def update
    respond_to do |format|
      if @control.update(control_params)
        format.html { redirect_to @control, notice: 'Control actualizado exitosamente.' }
        format.json { render :show, status: :ok, location: @control }
      else
        format.html { render :edit }
        format.json { render json: @control.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /controls/1
  # DELETE /controls/1.json
  def destroy
    @control.destroy
    respond_to do |format|
      format.html { redirect_to controls_url, notice: 'Control eliminado exitosamente.' }
      format.json { head :no_content }
    end
  end

  private
  
    def initialize_vars
      
    end
  
    # Use callbacks to share common setup or constraints between actions.
    def set_control
      @control = Control.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def control_params
      params.require(:control).permit(:ctrl_descripcion, :ctrl_html_id, :ctrl_tipo, :modelo_id, :accion_id, :ctrl_created_by, :ctrl_updated_by, :ctrl_estadoRegistro)
    end
end
