class AboutController < ApplicationController
  include AeropuertosHelper
  include PersonasHelper
  
  before_action :initialize_vars_global, only: [:index, :admon, :somos, :mensaje_contacto, :contacto, :mensaje, :detalle_reserva, :confirmacion_reserva]
  
  def index
    @ciudadesAeropuertos = set_ciudades_aeropuertos
  end
  
  def detalle_reserva
    
    @datosProducto = params[:datosProducto].split("|")
    @tipoProducto = @datosProducto[0]
    idProducto = @datosProducto[1]
    
    case @tipoProducto
      when "VUELO" then
        @producto = "DATOS DEL " + tipoProducto
      when "PAQUETUR" then
        paquete = PaqueteTuristico.find(idProducto)
        @producto = "PLAN " + paquete.pqTur_nombre  
    end
    
    #Entidad territorial Origen
    @enterOrigen = EntidadTerritorial.find(params[:cboOrigen])
    @enterDestino = EntidadTerritorial.new
    unless params[:cboDestino].blank?
      @enterDestino.destroy
      #Entidad Territorial Destino
      @enterDestino = EntidadTerritorial.find(params[:cboDestino])
    end
    #Fecha de Ida
    @dtFechaIda = params[:txtFechaIda]
    #Fecha de Regreso
    @dtFechaRegreso = params[:txtFechaRegreso]
    @tiposIdAdulto = set_tipos_id_persona("ADULTO")
    @tiposIdMenor = set_tipos_id_persona("MENOR")
    @tiposIdInfante = set_tipos_id_persona("INFANTE")
    @nroAdultos = params[:cboAdultos].to_i
    @nroMenores = params[:cboMenores].to_i
    @nroInfantes = params[:cboInfantes].to_i
  end
  
  def confirmar_reserva
    @datosContacto = params[:contacto]
    @datosReserva = params[:reserva]
    @datosViaje = params[:datos_viaje]
    
    if params[:datos_viaje].nil?
      respond_to do |format|
        format.html { redirect_to home_path }
        #format.json { render action: 'mensaje', status: :created, location: @entidad }
      end      
    else
      arrDatosViaje = params[:datos_viaje].split("|")
      @producto = arrDatosViaje[0]
      @enterOrigen = EntidadTerritorial.find(arrDatosViaje[1])
      
      unless arrDatosViaje[2].blank?
        @enterDestino = EntidadTerritorial.find(arrDatosViaje[2])
      end
      
      @dtFechaIda = arrDatosViaje[3]
      @dtFechaRegreso = arrDatosViaje[4]
      @nroAdultos = arrDatosViaje[5].to_i
      @nroMenores = arrDatosViaje[6].to_i
      @nroInfantes = arrDatosViaje[7].to_i
    end
    
  end
  
  def registrar_reserva
    
      msj = "Apreciado(a) cliente, su solicitud de reserva ha sido enviada exitosamente. En breve sera contactado para confirmar su orden."
      
      datosContacto = params[:contacto]      
      datosReserva = params[:datos_reserva]
      datosViaje = params[:datos_viaje]
      
      datosContacto = eval(datosContacto)
      datosReserva = eval(datosReserva)
      
      UserMailer.correo_reservas(datosViaje, datosContacto, datosReserva).deliver_now
      
      respond_to do |format|
        format.html { redirect_to mensaje_path, notice: msj }
        #format.json { render action: 'mensaje', status: :created, location: @entidad }
      end
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
