class AboutController < ApplicationController
  include AeropuertosHelper
  include PersonasHelper
  
  before_action :initialize_vars_global, only: [:index, :admon, :somos, :mensaje_contacto, :contacto, :mensaje]
  
  def index
    @ciudadesAeropuertos = set_ciudades_aeropuertos
  end
  
  def mensaje_contacto
      msj = "Apreciado(a) cliente, agradecemos nos haya contactado. En breve daremos respuesta a su solicitud."
      
      hshMensaje = Hash.new
      hshMensaje["tipo_mensaje"] = params[:tipo_mensaje]
      hshMensaje["remitente"] = params[:pers_nombreCompleto]
      hshMensaje["correo"] = params[:pers_correoElectronico]
      hshMensaje["telefono"] = params[:pers_telefono]
      hshMensaje["asunto"] = params[:msj_asunto]
      hshMensaje["contenido"] = params[:msj_contenido]      
      
      UserMailer.correo_contacto(hshMensaje).deliver_now
      
      respond_to do |format|
        format.html { redirect_to mensaje_path, notice: msj }
        #format.json { render action: 'mensaje', status: :created, location: @entidad }
      end
  end
  
  def contacto
    
  end
  
    # Never trust parameters from the scary internet, only allow the white list through.
    def detalle_reserva_params
      params.require(:about).permit(:cboOrigen, :cboDestino, :txtFechaSalida, :txtFechaRegreso, :cboAdultos, :cboMenores, :cboInfantes, :pers_nombreCompleto, :pers_correoElectronico, :pers_telefono, :tipo_mensaje, :msj_asunto, :msj_contenido)
    end  
end
